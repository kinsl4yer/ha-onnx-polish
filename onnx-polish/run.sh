#!/bin/bash
set -e

# Read options from Home Assistant
CONFIG_PATH=/data/options.json

MODEL=$(jq -r '.model // "OpenVoiceOS/yuriyvnv-parakeet-tdt-0.6b-pl-onnx"' "$CONFIG_PATH")
LANGUAGES=$(jq -r '.languages // "pl"' "$CONFIG_PATH")
DEFAULT_LANGUAGE=$(jq -r '.default_language // "pl"' "$CONFIG_PATH")
QUANTIZATION=$(jq -r '.quantization // "int8"' "$CONFIG_PATH")

export STT_MODEL="${MODEL}"
export STT_LANGUAGES="${LANGUAGES}"
export STT_DEFAULT_LANGUAGE="${DEFAULT_LANGUAGE}"
export STT_QUANTIZATION="${QUANTIZATION}"

echo "Starting ONNX ASR Polish with model: ${STT_MODEL}"

exec python -m wyoming_onnx_stt \
  --uri 'tcp://0.0.0.0:10300' \
  --model "${STT_MODEL}" \
  --language "${DEFAULT_LANGUAGE}"
