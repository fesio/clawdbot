# Jak Uruchomić Aplikację Clawdbot na Telefonie z Androidem

## Szybki Start

### 1. Sprawdź Środowisko Programistyczne

```bash
./scripts/check-android-env.sh
```

Ten skrypt sprawdzi, czy masz wszystko, czego potrzebujesz do zbudowania aplikacji.

### 2. Zbuduj i Zainstaluj Aplikację

```bash
# Zbuduj aplikację
./scripts/build-android.sh debug

# LUB zbuduj i od razu zainstaluj na podłączonym telefonie
./scripts/build-android.sh debug install
```

### 3. Co Dalej?

Po zainstalowaniu aplikacji na telefonie:

1. **Uruchom Gateway** na swoim komputerze (macOS, Linux lub Windows z WSL2):
   ```bash
   clawdbot gateway --port 18789 --verbose
   ```

2. **Otwórz aplikację Clawdbot** na telefonie
   - Przejdź do **Ustawienia**
   - Wybierz wykryty gateway lub wprowadź ręcznie adres

3. **Zatwierdź parowanie** na komputerze z gateway:
   ```bash
   clawdbot nodes pending
   clawdbot nodes approve <requestId>
   ```

## Szczegółowa Dokumentacja

### Kompletny Przewodnik Instalacji

Jeśli to Twoja pierwsza instalacja lub napotkasz problemy, przeczytaj szczegółowy przewodnik:

- **Polski**: [docs/platforms/android-setup-pl.md](docs/platforms/android-setup-pl.md)
- **English**: [docs/platforms/android-setup.md](docs/platforms/android-setup.md)

Przewodniki zawierają:
- Szczegółowe instrukcje instalacji Java i Android SDK
- Konfigurację środowiska programistycznego
- Rozwiązywanie typowych problemów
- Różne metody instalacji (Android Studio, narzędzia wiersza poleceń)

### Połączenie z Gateway

Po zainstalowaniu aplikacji, zobacz:
- [docs/platforms/android.md](docs/platforms/android.md) - Kompletny przewodnik połączenia

## Wymagania

- **Java**: JDK 17 lub nowsze
- **Android SDK**: API 31+ (Android 12+)
- **Telefon**: Android 12 lub nowszy

## Wsparcie

Jeśli napotkasz problemy:

1. Uruchom `./scripts/check-android-env.sh` aby sprawdzić konfigurację
2. Sprawdź sekcję "Rozwiązywanie Problemów" w przewodniku instalacji
3. Zobacz dokumentację online: [https://docs.clawd.bot/platforms/android-setup](https://docs.clawd.bot/platforms/android-setup)

## Licencja

Zobacz [LICENSE](LICENSE) w głównym katalogu projektu.
