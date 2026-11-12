# Home Assistant Add-on: ONNX ASR Polish

Add-on uruchamiający jednocześnie dwa modele Speech-to-Text (STT) zoptymalizowane pod język polski, udostępniane przez protokół Wyoming. FastConformer (port 10301) jest bardzo szybki, ale nieco mniej dokładny — dobry do codziennych komend. Parakeet (port 10300) jest wolniejszy, ale zwykle dokładniejszy.

- **Port 10300** – Parakeet TDT 0.6B Polish  
- **Port 10301** – FastConformer Hybrid Large PC Polish  

Po starcie w Home Assistant pojawią się dwa niezależne serwisy Wyoming, które możesz przypisać do różnych pipeline’ów Voice Assistant.

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
  Podczas budowania obrazu Docker mogą pojawić się błędy `no space left on device` (szczególnie przy rozpakowywaniu warstw CUDA). W razie potrzeby:
  - Zwiększ dysk VM (jeśli HAOS działa na Proxmoxie / wirtualizacji)
  - Wyczyść nieużywane obrazy Docker (`docker system prune` w terminalu HAOS)
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
