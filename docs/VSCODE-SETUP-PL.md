# Sprawdzenie Gotowości Bota - Visual Studio Code Setup

**Język:** Polski | [English](VSCODE-SETUP-EN.md)

## Problem
"SPRAWDZ CZY BOT JEST GOTOWY DO ODPALNIA POOPRZEZ WLACZENIE VISUAL CODE"

## Rozwiązanie

Ten dokument zawiera kompletny przewodnik po sprawdzeniu czy Clawdbot jest gotowy do uruchomienia w Visual Studio Code.

## Krok 1: Sprawdź Wymagania Systemowe

### Wymagane:
- **Node.js ≥ 22.12.0**
- **npm** (instalowany z Node.js)
- **Visual Studio Code**

### Zalecane:
- **pnpm** (szybszy package manager)
- **Git**

### Sprawdź Wersje:

```bash
# Sprawdź Node.js
node --version
# Powinno być: v22.12.0 lub wyżej

# Sprawdź npm
npm --version

# Sprawdź pnpm (opcjonalnie)
pnpm --version
```

## Krok 2: Automatyczna Weryfikacja

Użyj skryptu weryfikacyjnego:

```bash
cd /ścieżka/do/clawdbot
bash scripts/verify-vscode-ready.sh
```

Ten skrypt sprawdzi:
- ✓ Wersję Node.js
- ✓ Dostępność npm/pnpm
- ✓ Czy zależności są zainstalowane
- ✓ Czy projekt jest zbudowany
- ✓ Konfigurację VSCode
- ✓ Plik środowiskowy (.env)
- ✓ Status git

### Przykładowy Wynik:

```
🦞 Clawdbot - Readiness Check
==============================

Checking Node.js version... ✓ Node.js 24.13.0 (>= 22.12.0 required)
Checking npm... ✓ npm 11.6.2
Checking pnpm (recommended)... ✓ pnpm 10.23.0
Checking dependencies... ✓ Dependencies installed
Checking TypeScript... ✓ TypeScript available
Checking build artifacts... ✓ Project is built
Checking VSCode configuration... ✓ VSCode configuration exists
Checking environment configuration... ✓ .env file exists
Checking git status... ✓ Working tree is clean

==============================
✅ All checks passed! Bot is ready to run.
```

## Krok 3: Instalacja Zależności (jeśli potrzebne)

Jeśli weryfikacja pokazała brakujące zależności:

```bash
# Preferowany sposób (z pnpm)
pnpm install

# Lub z npm
npm install
```

## Krok 4: Budowanie Projektu (jeśli potrzebne)

```bash
# Zbuduj kod TypeScript
npm run build

# Opcjonalnie: zbuduj UI
npm run ui:build
```

## Krok 5: Konfiguracja Visual Studio Code

### Automatyczna Instalacja:

```bash
bash scripts/setup-vscode.sh
```

To utworzy katalog `.vscode/` z:
- `settings.json` - Ustawienia projektu
- `launch.json` - Konfiguracje debugowania
- `tasks.json` - Zadania build/test
- `extensions.json` - Zalecane rozszerzenia

### Ręczna Instalacja:

```bash
cp -r .vscode.example .vscode
```

## Krok 6: Otwarcie w Visual Studio Code

```bash
# Z terminala
code .

# Lub otwórz VSCode i wybierz File -> Open Folder
```

## Krok 7: Instalacja Rozszerzeń

Gdy otworzysz projekt w VSCode:

1. VSCode zapyta: "Do you want to install the recommended extensions?"
2. Kliknij **"Install"** lub **"Show Recommendations"**

Zalecane rozszerzenia:
- ESLint - Linting
- Prettier - Formatowanie kodu
- Vitest Explorer - Uruchamianie testów
- GitLens - Rozszerzona integracja Git

## Krok 8: Sprawdzenie że Bot Jest Gotowy

### Metoda 1: Uruchom Build Task

1. Naciśnij **Cmd/Ctrl+Shift+B**
2. Wybierz **"Build"**
3. Sprawdź Output w terminalu VSCode

Jeśli build się powiódł - bot jest gotowy! ✅

### Metoda 2: Uruchom Testy

1. Naciśnij **Cmd/Ctrl+Shift+T**
2. Lub uruchom task: **"Test"**
3. Testy powinny przejść bez błędów

### Metoda 3: Uruchom Gateway w Trybie Debug

1. Naciśnij **F5** lub przejdź do **Run & Debug** (Cmd/Ctrl+Shift+D)
2. Wybierz **"Debug Gateway"**
3. Kliknij zieloną strzałkę ▶️
4. Gateway powinien wystartować w terminalu

Jeśli zobaczysz coś podobnego - działa! ✅
```
Gateway listening on ws://0.0.0.0:18789
```

### Metoda 4: Uruchom Gateway z Terminala VSCode

W terminalu VSCode:

```bash
npm run gateway:watch
```

To uruchomi gateway w trybie deweloperskim z auto-reload.

## Krok 9: Testowanie Funkcjonalności Bota

### Test 1: Sprawdź Status Gateway

```bash
npm run clawdbot gateway status
```

### Test 2: Uruchom Prostą Komendę

```bash
npm run clawdbot -- --version
```

### Test 3: Test Agenta AI (wymaga konfiguracji)

```bash
npm run clawdbot agent --message "Hello, are you working?" --thinking high
```

## Rozwiązywanie Problemów

### Problem: "Cannot find module"

**Rozwiązanie:**
```bash
npm install
npm run build
```

### Problem: "Port 18789 already in use"

**Rozwiązanie:**
```bash
# Zatrzymaj istniejący gateway
npm run clawdbot gateway stop

# Lub znajdź i zabij proces
lsof -i :18789
kill -9 <PID>
```

### Problem: "TypeScript errors"

**Rozwiązanie:**
```bash
# Wyczyść i przebuduj
rm -rf dist
npm run build
```

### Problem: "VSCode nie wykrywa TypeScript"

**Rozwiązanie:**
1. Otwórz dowolny plik `.ts`
2. Naciśnij **Cmd/Ctrl+Shift+P**
3. Wpisz: "TypeScript: Select TypeScript Version"
4. Wybierz: "Use Workspace Version"

### Problem: "Tests nie działają"

**Rozwiązanie:**
```bash
# Zainstaluj Vitest extension w VSCode
# Lub uruchom z terminala
npm test
```

## Szybki Start - Checklist

Użyj tej checklisty aby upewnić się że wszystko działa:

- [ ] Node.js ≥ 22.12.0 zainstalowany
- [ ] `npm install` wykonany
- [ ] `npm run build` zakończony sukcesem
- [ ] `.vscode/` katalog istnieje
- [ ] VSCode otwarty w katalogu projektu
- [ ] Zalecane rozszerzenia zainstalowane
- [ ] `Cmd/Ctrl+Shift+B` buduje bez błędów
- [ ] `F5` uruchamia debugger
- [ ] Gateway startuje na porcie 18789
- [ ] `npm test` przechodzi

## Następne Kroki

Po zweryfikowaniu że bot jest gotowy:

1. **Przeczytaj dokumentację:**
   - [Getting Started](https://docs.clawd.bot/start/getting-started)
   - [Contributing Guide](CONTRIBUTING.md)
   - [VSCode Setup README](.vscode.example/README-PL.md)

2. **Skonfiguruj bota:**
   ```bash
   npm run clawdbot onboard
   ```

3. **Zacznij rozwijać:**
   - Ustaw breakpointy w kodzie
   - Modyfikuj i testuj
   - Używaj `npm run gateway:watch` dla auto-reload

## Dokumentacja VSCode

Szczegółowa dokumentacja konfiguracji VSCode:
- [README.md](.vscode.example/README.md) - Angielski
- [README-PL.md](.vscode.example/README-PL.md) - Polski

## Pomoc

Jeśli masz problemy:
1. Uruchom: `bash scripts/verify-vscode-ready.sh`
2. Przeczytaj sekcję Rozwiązywanie Problemów
3. Sprawdź [GitHub Issues](https://github.com/clawdbot/clawdbot/issues)
4. Dołącz do [Discord](https://discord.gg/clawd)

---

**Status:** ✅ Bot jest gotowy do uruchomienia w Visual Studio Code!
