# Home Assistant Add-on: ONNX ASR Polish

Niniejsze repozytorium to hobbystyczny vibe coding z użyciem modelu Grok.

Add-on uruchamiający jednocześnie dwa modele Speech-to-Text (STT) zoptymalizowane pod język polski, udostępniane przez protokół Wyoming:

- Parakeet TDT 0.6B Polish - wolniejszy, ale zwykle dokładniejszy (`https://huggingface.co/OpenVoiceOS/parakeet-tdt-0.6b-polish-coreml`)
- FastConformer Hybrid Large PC Polish - bardzo szybki, ale nieco mniej dokładny (`https://huggingface.co/nvidia/stt_pl_fastconformer_hybrid_large_pc`)


## Instalacja

1. Przejdź do **Ustawienia → Aplikacje → Zainstaluj aplikację**
2. Kliknij menu **⋮** → **Repozytoria**
3. Dodaj adres URL tego repozytorium:  
   `https://github.com/kinsl4yer/ha-onnx-polish`
4. Znajdź **ONNX ASR Polish** i zainstaluj
5. Uruchom add-on
6. Dodaj integrację **Wyoming** w Home Assistant (powinna zostać wykryta automatycznie)

### Wymagania i uwagi instalacyjne

- Przy pierwszym uruchomieniu modele zostaną pobrane z Hugging Face (łącznie kilka GB).
- **Zalecane wolne miejsce na dysku HAOS**: minimum 10–15 GB wolnego miejsca.  
- Add-on działa na architekturach `amd64` i `aarch64`.
- Na maszynach bez GPU (np. Intel N100) modele działają na CPU (ONNX Runtime automatycznie przechodzi na `CPUExecutionProvider`).

## Użycie w Home Assistant

1. Po uruchomieniu add-onu dodaj integrację **Wyoming**.
2. Powinny pojawić się dwa serwisy:
   - `wyoming-parakeet-pl` (port 10300)
   - `wyoming-fastconformer-pl` (port 10301)
3. W **Ustawienia → Voice assistants** utwórz lub edytuj pipeline i wybierz jeden z modeli jako Speech-to-text.
4. Ustaw język na **polski**.

## Licencja

Na podstawie obrazu bazowego `lmo3/wyoming-onnx-stt`.
