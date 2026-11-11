# Home Assistant Add-on: ONNX ASR Polish

Parakeet TDT 0.6B model fine-tuned for Polish language.

## Installation

1. Go to **Settings → Apps → Install apps*
2. Click the **⋮** menu → **Repositories**
3. Add this repository URL
4. Find **ONNX ASR Polish** and install it
5. Start the add-on
6. Add Wyoming integration in Home Assistant (it should be auto-discovered)

## Configuration

| Option | Default | Description |
|--------|---------|-------------|
| model | OpenVoiceOS/yuriyvnv-parakeet-tdt-0.6b-pl-onnx | Hugging Face model |
| languages | pl | Advertised languages |
| default_language | pl | Default language |
| quantization | int8 | none / int8 / fp16 |

## Notes

- First start will download the model (~2 GB)
- After starting, add it as Speech-to-text in your Voice Assistant pipeline
- Set language to Polish
