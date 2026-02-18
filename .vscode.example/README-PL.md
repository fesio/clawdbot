# Konfiguracja VSCode dla Clawdbot (Polish)

Ten katalog zawiera zalecaną konfigurację VSCode do rozwoju Clawdbot.

## Szybka Instalacja

Skopiuj te pliki, aby utworzyć lokalne środowisko VSCode:

```bash
# Z głównego katalogu projektu
cp -r .vscode.example .vscode
```

Lub użyj skryptu instalacyjnego:

```bash
bash scripts/setup-vscode.sh
```

## Co Jest Zawarte

### `settings.json`
- Konfiguracja TypeScript
- Powiązania i wykluczenia plików
- Automatyczne formatowanie
- Integracja z Vitest
- Preferencje edytora

### `launch.json`
Konfiguracje debugowania dla:
- **Debug Gateway**: Uruchom i debuguj serwer gateway
- **Debug CLI**: Uruchom i debuguj dowolne polecenie CLI
- **Debug Agent**: Uruchom i debuguj agenta AI
- **Debug Tests**: Uruchom i debuguj pliki testowe
- **Debug Current Test File**: Debuguj aktualnie otwarty plik testowy

### `tasks.json`
Zadania VSCode dla typowych operacji:
- **Build**: Kompiluj TypeScript (Cmd/Ctrl+Shift+B)
- **Build and Watch**: Kompiluj z auto-przeładowaniem
- **Lint**: Uruchom oxlint na kodzie źródłowym
- **Format**: Auto-formatuj kod z oxfmt
- **Test**: Uruchom wszystkie testy (Cmd/Ctrl+Shift+T)
- **Test Watch**: Uruchom testy w trybie watch
- **Start Gateway**: Uruchom gateway w trybie dev
- **Build UI**: Zbuduj interfejs kontrolny
- **Clean and Rebuild**: Świeża kompilacja

### `extensions.json`
Zalecane rozszerzenia VSCode:
- ESLint
- Prettier
- Vitest Explorer
- GitLens
- Wsparcie Markdown
- Path IntelliSense
- Sprawdzanie pisowni
- I więcej...

## Użycie

### Budowanie Projektu

1. **Zainstaluj zależności:**
   - Otwórz Paletę Poleceń (Cmd/Ctrl+Shift+P)
   - Uruchom zadanie: "Install Dependencies"
   - Lub użyj terminala: `npm install`

2. **Zbuduj TypeScript:**
   - Naciśnij Cmd/Ctrl+Shift+B (domyślne zadanie build)
   - Lub uruchom zadanie: "Build"
   - Lub użyj terminala: `npm run build`

### Uruchamianie Bota

1. **Uruchom Gateway w Trybie Dev:**
   - Uruchom zadanie: "Start Gateway"
   - Lub użyj terminala: `npm run gateway:watch`
   - Automatyczne przeładowanie przy zmianach kodu

2. **Debuguj Gateway:**
   - Naciśnij F5 lub przejdź do panelu Run & Debug
   - Wybierz "Debug Gateway"
   - Ustaw breakpointy w kodzie

### Testowanie

1. **Uruchom Wszystkie Testy:**
   - Naciśnij Cmd/Ctrl+Shift+T
   - Lub uruchom zadanie: "Test"

2. **Debuguj Plik Testowy:**
   - Otwórz plik testowy (*.test.ts)
   - Naciśnij F5 lub wybierz "Debug Current Test File"
   - Ustaw breakpointy według potrzeb

3. **Tryb Watch:**
   - Uruchom zadanie: "Test Watch"
   - Testy są ponownie uruchamiane przy zmianach plików

### Debugowanie

Konfiguracje debugowania pozwalają na:

1. **Debug Gateway**: Pełne debugowanie serwera gateway
   - Ustaw breakpointy w kodzie gateway
   - Sprawdzaj zmienne
   - Krokuj przez kod

2. **Debug CLI Commands**: Testuj dowolne polecenie CLI
   - Wprowadź polecenie gdy zostaniesz poproszony, np.: `gateway status`
   - Debuguj wykonanie polecenia

3. **Debug Agent**: Testuj funkcjonalność agenta AI
   - Wprowadź wiadomość gdy zostaniesz poproszony
   - Debuguj przetwarzanie przez agenta

## Skróty Klawiszowe

- **Build**: Cmd/Ctrl+Shift+B
- **Test**: Cmd/Ctrl+Shift+T
- **Debug**: F5
- **Paleta Poleceń**: Cmd/Ctrl+Shift+P
- **Szybkie Otwieranie**: Cmd/Ctrl+P

## Dostosowywanie

Możesz modyfikować te pliki według swoich potrzeb:
- Dodaj własne zadania
- Utwórz nowe konfiguracje debugowania
- Dostosuj ustawienia edytora
- Dodaj więcej rozszerzeń

Katalog `.vscode/` jest w gitignore, więc Twoje lokalne zmiany nie będą commitowane.

## Wymagania

- **Node.js**: ≥22.12.0 (wymaganie projektu)
- **VSCode**: Zalecana najnowsza stabilna wersja
- **Rozszerzenia**: Zainstaluj zalecane rozszerzenia gdy zostaniesz poproszony

## Rozwiązywanie Problemów

### Błędy "Cannot find module"
- Uruchom zadanie: "Install Dependencies"
- Lub: `npm install` w terminalu

### Błędy TypeScript
- Uruchom zadanie: "Build" aby skompilować
- Sprawdź czy `node_modules/typescript` jest zainstalowany

### Testy nie działają
- Upewnij się że rozszerzenie Vitest jest zainstalowane
- Sprawdź komunikaty błędów w terminalu

### Gateway nie startuje
- Sprawdź czy port 18789 jest już używany
- Uruchom: `clawdbot gateway status`
- Zatrzymaj istniejącą instancję: `clawdbot gateway stop`

## Więcej Informacji

- [Przewodnik Contributing](../CONTRIBUTING.md)
- [Dokumentacja](https://docs.clawd.bot)
- [Getting Started](https://docs.clawd.bot/start/getting-started)
- [macOS Dev Setup](../docs/platforms/mac/dev-setup.md)
