#!/bin/bash
# FastConformer Hybrid Large PC ships fp32 only. Dynamic int8 inserts ConvInteger
# nodes that ONNX Runtime cannot run on CPU, so quantization is intentionally omitted.
set -u

CONFIG_PATH=/data/options.json
DEFAULT_MODEL="OpenVoiceOS/stt_pl_fastconformer_hybrid_large_pc_onnx"

read_config() {
  python3 - "$CONFIG_PATH" "$DEFAULT_MODEL" <<'PY'
import json
import sys

path, default_model = sys.argv[1], sys.argv[2]
with open(path, encoding="utf-8") as handle:
    cfg = json.load(handle)

model = cfg.get("model") or cfg.get("fastconformer_model") or default_model
language = cfg.get("language") or cfg.get("default_language") or "pl"
device = cfg.get("device") or "cpu"
if device not in ("cpu", "cuda"):
    device = "cpu"

print(model)
print(language)
print(device)
PY
}

mapfile -t cfg < <(read_config)
MODEL="${cfg[0]}"
LANGUAGE="${cfg[1]}"
DEVICE="${cfg[2]}"

child=""

shutdown() {
  if [[ -n "$child" ]] && kill -0 "$child" 2>/dev/null; then
    kill -TERM "$child" 2>/dev/null || true
    wait "$child" 2>/dev/null || true
  fi
  exit 0
}
trap shutdown TERM INT

echo "Starting FastConformer Polish on :10301 model=${MODEL} device=${DEVICE} quantization=fp32"

while true; do
  python -m wyoming_onnx_stt \
    --uri "tcp://0.0.0.0:10301" \
    --model "$MODEL" \
    --languages "$LANGUAGE" \
    --default-language "$LANGUAGE" \
    --device "$DEVICE" \
    --zeroconf "wyoming-fastconformer-pl" &
  child=$!
  wait "$child"
  status=$?
  child=""

  # Clean exit or signal from Supervisor. OOM kill is 137 and must restart.
  if [[ "$status" -eq 0 || "$status" -eq 130 || "$status" -eq 143 ]]; then
    exit 0
  fi

  echo "wyoming-onnx-stt exited with status ${status}, restarting in 5s"
  sleep 5 &
  child=$!
  wait "$child" || true
  child=""
done
