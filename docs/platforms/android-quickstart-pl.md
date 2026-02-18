---
summary: "Szybki start: Instalacja i uruchomienie Clawdbot na telefonie Android"
---

# Szybki Start - Android

Ten przewodnik pomoże Ci szybko uruchomić Clawdbot na Twoim telefonie Android.

## Wymagania

- Telefon Android z systemem Android 12 (API 31) lub nowszym
- Komputer z uruchomionym Gateway (macOS, Linux lub Windows z WSL2)
- Oba urządzenia w tej samej sieci LUB połączone przez Tailscale

## Opcja 1: Instalacja gotowego APK (Zalecana)

Jeśli nie chcesz budować z kodu źródłowego, możesz użyć gotowego APK:

1. **Pobierz APK** z najnowszego wydania na GitHub
2. **Włącz instalację z nieznanych źródeł:**
   - Przejdź do Ustawienia → Bezpieczeństwo → Nieznane źródła
   - Lub Ustawienia → Aplikacje → Specjalny dostęp → Instaluj nieznane aplikacje
   - Zezwól przeglądarce lub menedżerowi plików na instalację aplikacji
3. **Zainstaluj APK** klikając na pobrany plik
4. **Przyznaj uprawnienia** gdy zostaniesz o to poproszony (aparat, powiadomienia, itp.)

## Opcja 2: Budowanie z kodu źródłowego

### Konfiguracja środowiska Android

1. **Zainstaluj Android Studio** z https://developer.android.com/studio
2. **Zainstaluj Android SDK:**
   - Otwórz Android Studio
   - Przejdź do Tools → SDK Manager
   - Zainstaluj Android SDK Platform 36 (lub najnowszą)
   - Zainstaluj Android SDK Build-Tools
3. **Ustaw zmienne środowiskowe** (opcjonalnie):
   ```bash
   export ANDROID_HOME=$HOME/Library/Android/sdk  # macOS
   # lub
   export ANDROID_HOME=$HOME/Android/Sdk  # Linux
   ```

### Zbuduj APK

1. **Sklonuj repozytorium:**
   ```bash
   git clone https://github.com/clawdbot/clawdbot.git
   cd clawdbot
   ```

2. **Zbuduj debugową wersję APK:**
   ```bash
   cd apps/android
   ./gradlew :app:assembleDebug
   ```

3. **Znajdź APK:**
   APK będzie znajdował się w:
   ```
   apps/android/app/build/outputs/apk/debug/clawdbot-2026.1.25-debug.apk
   ```

4. **Zainstaluj na telefonie:**
   ```bash
   # Podłącz telefon przez USB i włącz debugowanie USB
   ./gradlew :app:installDebug
   
   # Lub przenieś plik APK na telefon i zainstaluj ręcznie
   ```

## Konfiguracja Gateway

Przed użyciem aplikacji Android potrzebujesz uruchomionego Gateway na innym komputerze.

### Uruchom Gateway

Na Twoim komputerze (macOS/Linux/Windows WSL2):

```bash
# Zainstaluj CLI clawdbot
npm install -g clawdbot

# Uruchom gateway
clawdbot gateway --port 18789 --verbose
```

Gateway uruchomi się i będzie nasłuchiwał na `ws://0.0.0.0:18789`.

### Dla użytkowników Tailscale (Zdalna konfiguracja)

Jeśli Twój telefon i komputer są w różnych lokalizacjach, ale połączone przez Tailscale:

1. **Podłącz gateway do Tailscale:**
   ```bash
   clawdbot config set gateway.bind tailnet
   ```

2. **Uruchom ponownie gateway:**
   ```bash
   clawdbot gateway --port 18789
   ```

## Połączenie telefonu Android

### Krok 1: Otwórz aplikację Clawdbot

Uruchom aplikację Clawdbot na swoim telefonie Android.

### Krok 2: Połącz się z Gateway

#### Automatyczne wykrywanie (Sieć lokalna)

1. Dotknij **Ustawienia** w aplikacji
2. Szukaj w sekcji **Odkryte Gateways**
3. Wybierz swój gateway z listy
4. Dotknij **Połącz**

#### Ręczne połączenie (Tailscale lub jeśli wykrywanie nie działa)

1. Dotknij **Ustawienia** → **Zaawansowane** → **Ręczny Gateway**
2. Wprowadź szczegóły gateway:
   - **Host:** Adres IP lub nazwa hosta Twojego komputera
     - Lokalny: `192.168.1.x` lub `<nazwa-hosta>.local`
     - Tailscale: Użyj nazwy MagicDNS lub IP Tailscale
   - **Port:** `18789`
3. Dotknij **Połącz (Ręcznie)**

### Krok 3: Zatwierdź parowanie

Na swoim komputerze uruchom:

```bash
# Wyświetl oczekujące żądania połączenia
clawdbot nodes pending

# Zatwierdź swoje urządzenie Android
clawdbot nodes approve <requestId>
```

### Krok 4: Sprawdź połączenie

Sprawdź, czy Twoje urządzenie Android jest połączone:

```bash
clawdbot nodes status
```

Powinieneś zobaczyć swoje urządzenie Android wymienione jako połączony węzeł.

## Używanie aplikacji

Po połączeniu możesz:

### Czat

- Dotknij **Czat** aby otworzyć interfejs czatu
- Wysyłaj wiadomości do swojego asystenta AI
- Przeglądaj historię czatu (współdzieloną między wszystkimi urządzeniami)

### Canvas

Wyświetlaj treści web lub niestandardowy interfejs:

```bash
# Z komputera wyślij treść na Android canvas
clawdbot nodes invoke --node "Android Node" --command canvas.navigate --params '{"url":"http://<gateway-host>:18793/__clawdbot__/canvas/"}'
```

### Aparat

Użyj aparatu telefonu:

```bash
# Zrób zdjęcie
clawdbot nodes invoke --node "Android Node" --command camera.snap

# Nagraj wideo
clawdbot nodes invoke --node "Android Node" --command camera.clip --params '{"duration":5}'
```

## Rozwiązywanie problemów

### Nie mogę znaleźć gateway w sieci

1. **Sprawdź czy oba urządzenia są w tej samej sieci:**
   ```bash
   # Na komputerze sprawdź czy gateway działa
   netstat -an | grep 18789
   ```

2. **Spróbuj ręcznego połączenia** z adresem IP zamiast nazwy hosta

3. **Sprawdź ustawienia firewall** - upewnij się że port 18789 nie jest zablokowany

### Odmowa dostępu

Przyznaj wymagane uprawnienia w Ustawieniach Android → Aplikacje → Clawdbot:
- Aparat (dla funkcji aparatu)
- Powiadomienia (dla usługi pierwszoplanowej)
- Urządzenia w pobliżu (dla wykrywania gateway na Android 13+)
- Lokalizacja (dla wykrywania gateway na Android 12 i niższych)

### Połączenie ciągle się przerywa

Aplikacja używa usługi pierwszoplanowej do utrzymania połączenia. Jeśli trwałe powiadomienie znika, uruchom aplikację ponownie.

### Budowanie kończy się niepowodzeniem

Jeśli budowanie z kodu źródłowego nie działa:
- Upewnij się że masz zainstalowany Android SDK Platform 36
- Sprawdź czy masz zainstalowaną Javę 17: `java -version`
- Spróbuj wyczyścić i przebudować:
  ```bash
  cd apps/android
  ./gradlew clean
  ./gradlew :app:assembleDebug
  ```

## Następne kroki

- Przeczytaj pełną [dokumentację platformy Android](/platforms/android)
- Dowiedz się o [konfiguracji gateway](/gateway/configuration)
- Poznaj [komendy aparatu](/nodes/camera)
- Skonfiguruj [funkcje Voice Wake](/features/voice-wake)

## Uzyskiwanie pomocy

- Sprawdź [GitHub Issues](https://github.com/clawdbot/clawdbot/issues)
- Przeczytaj [przewodnik rozwiązywania problemów](/troubleshooting)
- Dołącz do dyskusji społeczności
