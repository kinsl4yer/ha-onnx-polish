# Home Assistant Add-on: ONNX ASR Polish

Add-on uruchamia jeden model Speech-to-Text dla języka polskiego i udostępnia go protokołem Wyoming:

* FastConformer Hybrid Large PC Polish (`OpenVoiceOS/stt_pl_fastconformer_hybrid_large_pc_onnx`), port **10301**

Model ma około 114 mln parametrów i jest eksportem fp32. Wariant int8 tego architektury nie działa na CPU: dynamiczna kwantyzacja wstawia węzły `ConvInteger`, których ONNX Runtime nie wykonuje. Dlatego add-on nie ustawia kwantyzacji.

Domyślne urządzenie to **CPU**. Obraz bazowy `lmo3/wyoming-onnx-stt` zakłada CUDA, a ta instalacja stoi na Intel N100 bez GPU.

## Instalacja

1. Przejdź do **Ustawienia → Aplikacje → Zainstaluj aplikację**
2. Kliknij menu **⋮** → **Repozytoria**
3. Dodaj adres URL tego repozytorium: `https://github.com/kinsl4yer/ha-onnx-polish`
4. Znajdź **ONNX ASR Polish** i zainstaluj
5. Uruchom add-on
6. Dodaj integrację **Wyoming** (host add-onu, port 10301)

### Aktualizacja z wersji z dwoma modelami

Wersja 1.2.0 usuwa Parakeet (port 10300) i zmienia schemat opcji. Po aktualizacji otwórz konfigurację add-onu i zapisz ją. Stare klucze `parakeet_model` i `quantization_*` nie przechodzą walidacji, więc Supervisor nie wystartuje kontenera, dopóki konfiguracja nie zostanie zapisana od nowa.

Integrację Wyoming **Parakeet** (port 10300) usuń. Zostaw wpis FastConformer na porcie **10301**. Lepiej podać nazwę DNS add-onu niż adres `172.30.32.x`, bo ten adres zmienia się po odtworzeniu kontenera.

## Konfiguracja

| Opcja | Domyślnie | Opis |
| --- | --- | --- |
| model | `OpenVoiceOS/stt_pl_fastconformer_hybrid_large_pc_onnx` | Repo modelu na Hugging Face |
| language | `pl` | Język reklamowany w Wyoming |
| device | `cpu` | `cpu` albo `cuda` |

## Użycie w Home Assistant

1. Po uruchomieniu dodaj integrację **Wyoming** na porcie 10301.
2. W **Ustawienia → Voice assistants** ustaw ten silnik jako Speech-to-text.
3. Ustaw język na **polski**.

Proces nasłuchu jest podnoszony ponownie, gdy ONNX Runtime zakończy się błędem albo sygnałem OOM. Supervisor dodatkowo sprawdza port 10301 i restartuje add-on, gdy port przestanie odpowiadać.

## Wymagania

* Przy pierwszym uruchomieniu model zostanie pobrany z Hugging Face.
* Zalecane wolne miejsce na dysku HAOS: kilka GB na cache modelu.
* Sprawdzone na HAOS jako VM na Proxmox, Intel N100, bez GPU.

## Licencja

Na podstawie obrazu bazowego `lmo3/wyoming-onnx-stt`.
