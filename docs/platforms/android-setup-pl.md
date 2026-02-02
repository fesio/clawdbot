---
summary: "Kompletny przewodnik budowania i instalacji aplikacji Clawdbot na Androida"
read_when:
  - Budowanie aplikacji Android po raz pierwszy
  - Konfiguracja środowiska deweloperskiego Android
  - Instalacja aplikacji na fizycznym urządzeniu lub emulatorze
---

# Aplikacja Android - Przewodnik Budowania i Instalacji

Ten przewodnik obejmuje wszystko, czego potrzebujesz, aby zbudować i zainstalować aplikację Clawdbot na swoim telefonie z Androidem.

## Szybkie Sprawdzenie Środowiska

Przed rozpoczęciem możesz sprawdzić, czy środowisko programistyczne jest gotowe:

```bash
./scripts/check-android-env.sh
```

Ten skrypt sprawdzi Javę, Android SDK i podłączone urządzenia. Jeśli brakuje jakichkolwiek wymagań, kontynuuj z wymaganiami wstępnymi poniżej.

## Wymagania Wstępne

### 1. Wymagania Systemowe

- **System operacyjny**: macOS, Linux lub Windows (z WSL2)
- **Java Development Kit (JDK)**: JDK 17 lub nowszy
- **Android SDK**: poziom API 31 lub wyższy (Android 12+)
- **Gradle**: Dołączony przez wrapper gradlew (nie wymaga osobnej instalacji)

### 2. Instalacja Java Development Kit (JDK)

Budowanie Android wymaga JDK 17 lub nowszego.

#### macOS

```bash
brew install openjdk@17
```

Po instalacji może być konieczne dodanie do PATH:

```bash
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install openjdk-17-jdk
```

#### Weryfikacja Instalacji Java

```bash
java -version
```

Powinieneś zobaczyć informację o wersji Java 17 lub nowszej.

### 3. Instalacja Android SDK

Masz dwie opcje: użyj Android Studio (zalecane dla początkujących) lub tylko narzędzi wiersza poleceń.

#### Opcja A: Android Studio (Zalecane)

1. Pobierz Android Studio z [developer.android.com](https://developer.android.com/studio)
2. Zainstaluj Android Studio
3. Uruchom Android Studio i przejdź przez kreatora konfiguracji
4. Kreator zainstaluje:
   - Android SDK
   - Android SDK Platform (API 31+)
   - Android Build Tools
   - Android Emulator (opcjonalnie, jeśli chcesz testować bez fizycznego urządzenia)

5. Zanotuj lokalizację SDK (zazwyczaj `~/Library/Android/sdk` na macOS lub `~/Android/Sdk` na Linuxie)

#### Opcja B: Tylko Narzędzia Wiersza Poleceń

Jeśli wolisz nie instalować Android Studio:

**macOS/Linux:**

```bash
# Utwórz katalog SDK
mkdir -p ~/Android/Sdk
cd ~/Android/Sdk

# Pobierz narzędzia wiersza poleceń (odwiedź https://developer.android.com/studio dla najnowszego URL)
# Dla macOS:
wget https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip
unzip commandlinetools-mac-11076708_latest.zip

# Dla Linux:
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip

# Ustaw zmienne środowiskowe
echo 'export ANDROID_SDK_ROOT=$HOME/Android/Sdk' >> ~/.zshrc  # lub ~/.bashrc
echo 'export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

# Zainstaluj wymagane komponenty SDK
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"
```

### 4. Ustaw Zmienne Środowiskowe

Dodaj te linie do konfiguracji powłoki (`~/.zshrc`, `~/.bashrc` lub `~/.profile`):

```bash
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk  # macOS
# lub
export ANDROID_SDK_ROOT=$HOME/Android/Sdk  # Linux

# Opcjonalnie, ale zalecane:
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
```

Przeładuj konfigurację powłoki:

```bash
source ~/.zshrc  # lub source ~/.bashrc
```

## Budowanie Aplikacji Android

### Szybkie Budowanie (Używając Skryptu Pomocniczego)

Najłatwiejszy sposób zbudowania i opcjonalnej instalacji aplikacji:

```bash
# Zbuduj tylko debug APK
./scripts/build-android.sh debug

# Zbuduj i zainstaluj na podłączonym urządzeniu
./scripts/build-android.sh debug install

# Zbuduj release APK
./scripts/build-android.sh release
```

### Ręczne Budowanie (Bezpośrednio Używając Gradle)

#### 1. Przejdź do Katalogu Aplikacji Android

```bash
cd /path/to/clawdbot/apps/android
```

#### 2. Zbuduj Debug APK

```bash
./gradlew :app:assembleDebug
```

To:
- Pobierze wszystkie wymagane zależności Gradle (tylko pierwszy raz)
- Skompiluje kod źródłowy Kotlin
- Spakuje aplikację do APK
- Plik wyjściowy: `app/build/outputs/apk/debug/clawdbot-2026.1.25-debug.apk`

**Uwaga**: Pierwsze budowanie może zająć kilka minut, ponieważ Gradle pobiera zależności.

#### 3. Zbuduj Release APK (Opcjonalnie)

Dla wersji produkcyjnej:

```bash
./gradlew :app:assembleRelease
```

**Uwaga**: Budowania release wymagają konfiguracji podpisywania. Do rozwoju i testowania użyj wersji debug.

## Instalacja Aplikacji

### Opcja 1: Instalacja na Fizycznym Urządzeniu (Zalecane)

#### Włącz Opcje Deweloperskie na Telefonie z Androidem

1. Otwórz **Ustawienia** na urządzeniu z Androidem
2. Przejdź do **O telefonie**
3. Stuknij **Numer kompilacji** 7 razy (zobaczysz komunikat "Jesteś teraz deweloperem")
4. Wróć do **Ustawienia** → **System** → **Opcje deweloperskie**
5. Włącz **Debugowanie USB**

#### Podłącz Urządzenie i Zainstaluj

1. Podłącz telefon z Androidem do komputera przez USB
2. Na telefonie zatwierdź połączenie debugowania USB, gdy zostaniesz poproszony

3. Sprawdź, czy urządzenie jest podłączone:

```bash
# Narzędzie adb powinno być w PATH po ustawieniu ANDROID_SDK_ROOT
adb devices
```

Powinieneś zobaczyć swoje urządzenie na liście.

4. Zainstaluj aplikację:

```bash
./gradlew :app:installDebug
```

Lub ręcznie zainstaluj APK:

```bash
adb install app/build/outputs/apk/debug/clawdbot-2026.1.25-debug.apk
```

### Opcja 2: Instalacja na Emulatorze

#### Utwórz Wirtualne Urządzenie Android (AVD)

Jeśli używasz Android Studio:

1. Otwórz Android Studio
2. Przejdź do **Tools** → **Device Manager**
3. Kliknij **Create Device**
4. Wybierz profil urządzenia (np. Pixel 7)
5. Pobierz obraz systemu (API 31 lub wyższe)
6. Zakończ kreator

Jeśli używasz narzędzi wiersza poleceń:

```bash
# Wyświetl dostępne obrazy systemu
sdkmanager --list | grep system-images

# Pobierz obraz systemu (przykład: Android 12)
sdkmanager "system-images;android-31;google_apis;x86_64"

# Utwórz AVD
avdmanager create avd -n ClawdbotTest -k "system-images;android-31;google_apis;x86_64"
```

#### Uruchom Emulator i Zainstaluj

```bash
# Uruchom emulator
emulator -avd ClawdbotTest

# W innym terminalu zainstaluj aplikację
cd /path/to/clawdbot/apps/android
./gradlew :app:installDebug
```

### Opcja 3: Ręczne Przesłanie APK na Telefon

1. Zbuduj APK:
```bash
./gradlew :app:assembleDebug
```

2. Prześlij plik APK na telefon:
   - Wyślij go do siebie mailem
   - Prześlij do chmury (Google Drive, Dropbox, itp.)
   - Użyj transferu plików USB

3. Na telefonie:
   - Otwórz plik APK
   - Może być konieczne włączenie "Instaluj nieznane aplikacje" dla menedżera plików
   - Postępuj zgodnie z instrukcjami instalacji

## Uruchamianie Aplikacji

1. Uruchom aplikację **Clawdbot** na urządzeniu z Androidem
2. Postępuj zgodnie z krokami połączenia w [Przewodniku Połączenia Android](/platforms/android)

## Rozwiązywanie Problemów

### "Lokalizacja SDK nie została znaleziona"

Skrypt gradlew automatycznie wykrywa Android SDK w typowych lokalizacjach:
- macOS: `~/Library/Android/sdk`
- Linux: `~/Android/Sdk`

Jeśli SDK jest w innej lokalizacji, ustaw zmienną środowiskową:

```bash
export ANDROID_SDK_ROOT=/ścieżka/do/twojego/android/sdk
```

Lub utwórz plik `local.properties` w `apps/android/`:

```properties
sdk.dir=/ścieżka/do/twojego/android/sdk
```

### "adb: polecenie nie znalezione"

Dodaj Android SDK platform-tools do PATH:

```bash
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
```

### Budowanie Kończy się Błędem "Wersja Java"

Upewnij się, że używasz JDK 17:

```bash
java -version
# Powinno pokazać wersję 17 lub wyższą
```

Jeśli masz wiele wersji Java, może być konieczne ustawienie JAVA_HOME:

```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 17)  # macOS
```

### Urządzenie Nie Jest Rozpoznawane

1. Upewnij się, że debugowanie USB jest włączone na telefonie
2. Spróbuj innego kabla USB (niektóre kable są tylko do ładowania)
3. Odwołaj autoryzacje debugowania USB na telefonie i spróbuj ponownie
4. Uruchom `adb kill-server && adb start-server`

### Budowanie Gradle Jest Wolne

Pierwsze budowania są zawsze wolniejsze. Aby przyspieszyć kolejne budowania:

1. Włącz demona Gradle (powinien być domyślnie włączony)
2. Zwiększ pamięć Gradle w `gradle.properties` (już ustawione na 3GB)
3. Użyj szybszego dysku (zalecany SSD)

## Następne Kroki

Po pomyślnej instalacji aplikacji:

1. Skonfiguruj Gateway na głównej maszynie - zobacz [Pierwsze Kroki](/start/getting-started)
2. Podłącz węzeł Android do Gateway - zobacz [Przewodnik Połączenia Android](/platforms/android)
3. Zatwierdź żądanie parowania - zobacz [Parowanie](/gateway/pairing)

## Wskazówki Deweloperskie

### Uruchamianie Testów

```bash
./gradlew :app:testDebugUnitTest
```

### Otwieranie w Android Studio

1. Otwórz Android Studio
2. Wybierz **File** → **Open**
3. Przejdź do i wybierz folder `apps/android`
4. Poczekaj na zakończenie synchronizacji Gradle

### Przebudowywanie Aplikacji

Po wprowadzeniu zmian w kodzie:

```bash
./gradlew :app:installDebug
```

To przebuduje i ponownie zainstaluje aplikację na podłączonym urządzeniu.

### Wyświetlanie Logów

```bash
adb logcat | grep Clawdbot
```

## Dodatkowe Zasoby

- [Dokumentacja Dewelopera Android](https://developer.android.com)
- [Narzędzie Budowania Gradle](https://gradle.org)
- [Android Debug Bridge (adb)](https://developer.android.com/tools/adb)
