#!/bin/bash
set -e

PARAKEET_MODEL=$(python3 -c "import json; print(json.load(open('/data/options.json'))['parakeet_model'])")
FASTCONFORMER_MODEL=$(python3 -c "import json; print(json.load(open('/data/options.json'))['fastconformer_model'])")
QUANT_P=$(python3 -c "import json; print(json.load(open('/data/options.json'))['quantization_parakeet'])")
QUANT_F=$(python3 -c "import json; print(json.load(open('/data/options.json'))['quantization_fastconformer'])")

# Parakeet — bez int8 (model tego nie obsługuje)
echo "Starting Parakeet on port 10300: $PARAKEET_MODEL"
python -m wyoming_onnx_stt \
  --uri tcp://0.0.0.0:10300 \
  --model "$PARAKEET_MODEL" \
  --languages pl \
  --default-language pl &

# FastConformer — quantization tylko jeśli nie jest "none"
echo "Starting FastConformer on port 10301: $FASTCONFORMER_MODEL"
if [ "$QUANT_F" = "none" ] || [ -z "$QUANT_F" ]; then
  python -m wyoming_onnx_stt \
    --uri tcp://0.0.0.0:10301 \
    --model "$FASTCONFORMER_MODEL" \
    --languages pl \
    --default-language pl &
else
  python -m wyoming_onnx_stt \
    --uri tcp://0.0.0.0:10301 \
    --model "$FASTCONFORMER_MODEL" \
    --languages pl \
    --default-language pl \
    --quantization "$QUANT_F" &
fi

wait
