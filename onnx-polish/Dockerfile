FROM lmo3/wyoming-onnx-stt:latest

ENTRYPOINT []
CMD ["python", "-m", "wyoming_onnx_stt", "--uri", "tcp://0.0.0.0:10300", "--model", "OpenVoiceOS/yuriyvnv-parakeet-tdt-0.6b-pl-onnx", "--languages", "pl", "--default-language", "pl", "--quantization", "int8"]
