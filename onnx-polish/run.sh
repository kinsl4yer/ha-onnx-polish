#!/bin/bash
set -e

# Odczyt opcji z /data/options.json (standard HA)
OPTIONS=$(cat /data/options.json)

PARAKEET_MODEL=$(echo "$OPTIONS" | jq -r '.parakeet_model')
FASTCONFORMER_MODEL=$(echo "$OPTIONS" | jq -r '.fastconformer_model')
QUANT_P=$(echo "$OPTIONS" | jq -r '.quantization_parakeet')
QUANT_F=$(echo "$OPTIONS" | jq -r '.quantization_fastconformer')

echo "Starting Parakeet on port 10300: $PARAKEET_MODEL"
python -m wyoming_onnx_stt \
  --uri tcp://0.0.0.0:10300 \
  --model "$PARAKEET_MODEL" \
  --languages pl \
  --default-language pl \
  --quantization "$QUANT_P" &

echo "Starting FastConformer on port 10301: $FASTCONFORMER_MODEL"
python -m wyoming_onnx_stt \
  --uri tcp://0.0.0.0:10301 \
  --model "$FASTCONFORMER_MODEL" \
  --languages pl \
  --default-language pl \
  --quantization "$QUANT_F" &

# Czekaj na procesy
wait
