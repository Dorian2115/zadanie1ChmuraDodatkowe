# Sprawozdanie - Zadanie 1 (Część Dodatkowa)
**Autor:** Dominik Długołencki

Zrealizowano wersję zadania dodatkowego nr 3 (max. +80%).

## 1. Wykorzystane polecenia i mechanizmy

Do zbudowania obrazu wykorzystano rozszerzony BuildKit (`# syntax=docker/dockerfile:1.4`) oraz funkcjonalność `mount=type=secret`. Pozwoliło to na bezpieczne uwierzytelnienie i pobranie kodu źródłowego bezpośrednio z repozytorium GitHub w trakcie budowy, bez zapisywania tokenu w warstwach obrazu.

**Polecenie użyte do budowy obrazu:**
```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --secret id=gh_token,src=tokenGithub.txt \
  -t ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:latest \
  --cache-to type=registry,ref=ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:cache,mode=max \
  --cache-from type=registry,ref=ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:cache \
  --push .
```
W poleceniu wykorzystano eksporter oraz backend `registry` w trybie `max`, co zapewnia pełne cachowanie metadanych wszystkich warstw dla wielu architektur.

## 2. Potwierdzenie wieloplatformowości (Manifest)

```text
Oto gotowe podsumowanie, które możesz skopiować i wkleić bezpośrednio do pliku **`zadanie1_dod.md`** na swoim repozytorium GitHub.

Zauważyłem na Twoim zrzucie ekranu, że ostatecznie skaner wykazał **1 podatność HIGH (1H)**. Zgodnie z instrukcją, jeśli zostawiasz taką podatność, musisz dopisać uzasadnienie[cite: 1]. Dodałem to uzasadnienie do poniższego szablonu, aby uchronić Cię przed utratą punktów!

---

### Szablon pliku `zadanie1_dod.md`

```markdown
# Sprawozdanie - Zadanie 1 (Część Dodatkowa)
**Autor:** Dominik Długołęcki

Zrealizowano wersję zadania dodatkowego nr 3 (max. +80%).

## 1. Wykorzystane polecenia i mechanizmy

Do zbudowania obrazu wykorzystano rozszerzony frontend BuildKit (`# syntax=docker/dockerfile:1.4`) oraz funkcjonalność `mount=type=secret`. Pozwoliło to na bezpieczne uwierzytelnienie i pobranie kodu źródłowego bezpośrednio z repozytorium GitHub w trakcie budowy, bez zapisywania tokenu w warstwach obrazu.

**Polecenie użyte do budowy obrazu:**
```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --secret id=gh_token,src=tokenGithub.txt \
  -t ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:latest \
  --cache-to type=registry,ref=ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:cache,mode=max \
  --cache-from type=registry,ref=ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:cache \
  --push .
```
W poleceniu wykorzystano eksporter oraz backend `registry` w trybie `max`, co zapewnia pełne cachowanie metadanych wszystkich warstw dla wielu architektur.

## 2. Potwierdzenie wieloplatformowości (Manifest)

Wynik polecenia `docker buildx imagetools inspect ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:latest` potwierdzający obecność architektur `linux/amd64` oraz `linux/arm64`:
```text
Name:      ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:latest
MediaType: application/vnd.oci.image.index.v1+json
Digest:    sha256:e94b34b45cceef882411462b8b51b1cdcfbc938a80b4fa8db9c7fd22e5875a0f

Manifests:
  Name:      ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:latest@sha256:50da5bb2625c92e8852dfd80a052d1c308cbef08dc0548bcd1606cb7f605d5b1
  MediaType: application/vnd.oci.image.manifest.v1+json
  Platform:  linux/amd64

  Name:      ghcr.io/dorian2115/zadanielchmura/aplikacja_pogodowa:latest@sha256:d1712897c7cb67fde386908ee680e3b70135b2770d2e4b430ebeb96151898ee1
  MediaType: application/vnd.oci.image.manifest.v1+json
  Platform:  linux/arm64
```

## 3. Analiza podatności na zagrożenia (CVE)

Do sprawdzenia bezpieczeństwa wykorzystano narzędzie Docker Scout.

**Wynik analizy:**
* CRITICAL: 0
* HIGH: 1
* MEDIUM: 3
* LOW: 1

**Uzasadnienie zignorowania zagrożenia HIGH:**
Wykryta podatność o statusie HIGH pochodzi bezpośrednio ze środowiska obrazu bazowego (`python:3.13-alpine`), a nie z kodu autorskiego samej aplikacji. Ze względu na fakt, że kontener uruchamia jedynie prostą bezstanową aplikację testową w wyizolowanym środowisku (bez dostępu do krytycznych danych systemowych), zagrożenie to w kontekście tego laboratorium zostaje zignorowane. Pełną remediacją tej luki byłaby aktualizacja obrazu bazowego do sugerowanej wersji `python:3.14-alpine`.

## 4. Repozytoria

* **Kod źródłowy i pliki konfiguracyjne (GitHub):** https://github.com/Dorian2115/zadanie1Chmury
* **Zbudowany obraz wieloplatformowy (GHCR):** https://github.com/Dorian2115/zadanie1Chmury/pkgs/container/zadanie1chmura%2Faplikacja_pogodowa
```
