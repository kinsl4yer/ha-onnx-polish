#!/bin/bash
set -e

PARAKEET_MODEL=$(python3 -c "import json; print(json.load(open('/data/options.json'))['parakeet_model'])")
FASTCONFORMER_MODEL=$(python3 -c "import json; print(json.load(open('/data/options.json'))['fastconformer_model'])")

echo "Starting Parakeet on port 10300: $PARAKEET_MODEL"
python -m wyoming_onnx_stt \
  --uri tcp://0.0.0.0:10300 \
  --model "$PARAKEET_MODEL" \
  --languages pl \
  --default-language pl \
  --zeroconf "wyoming-parakeet-pl" &

echo "Starting FastConformer on port 10301: $FASTCONFORMER_MODEL"
python -m wyoming_onnx_stt \
  --uri tcp://0.0.0.0:10301 \
  --model "$FASTCONFORMER_MODEL" \
  --languages pl \
  --default-language pl \
  --zeroconf "wyoming-fastconformer-pl" &

wait
