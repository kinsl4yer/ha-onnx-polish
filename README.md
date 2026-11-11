# Home Assistant Add-on: ONNX ASR Polish

## Modele

Add-on uruchamia dwa serwisy jednocześnie:

- **Port 10300** – Parakeet TDT 0.6B Polish
- **Port 10301** – FastConformer Hybrid Large PC Polish

Po starcie w Home Assistant pojawią się dwa serwisy Wyoming. Dodaj oba i używaj ich w różnych pipeline'ach Voice Assistant.

## Instalacja

1. Przejdź do **Ustawienia → Aplikacje → Zainstaluj aplikację**
2. Kliknij menu **⋮** → **Repozytoria**
3. Dodaj adres URL tego repozytorium
4. Znajdź **ONNX ASR Polish** i zainstaluj
5. Uruchom add-on
6. Dodaj integrację Wyoming w Home Assistant (powinna zostać wykryta automatycznie)

## Konfiguracja

| Opcja                | Domyślnie                                      | Opis                     |
| -------------------- | ---------------------------------------------- | ------------------------ |
| model                | OpenVoiceOS/yuriyvnv-parakeet-tdt-0.6b-pl-onnx | Model z Hugging Face     |
| languages            | pl                                             | Reklamowane języki       |
| default_language     | pl                                             | Domyślny język           |
| quantization         | int8                                           | none / int8 / fp16       |

## Uwagi

- Przy pierwszym uruchomieniu model zostanie pobrany (~2 GB)
- Po uruchomieniu dodaj go jako Speech-to-text w pipeline Voice Assistant
- Ustaw język na polski
