Repozytorium zawiera rozwiązanie części nieobowiązkowej zadania 1 (poziom 3)
### Analiza Podatności (CVE)
Obraz został poddany analizie pod kątem podatności przy użyciu narzędzia **Trivy**. Zgodnie z wymaganiami, obraz nie zawiera żadnych zagrożeń sklasyfikowanych jako CRITICAL lub HIGH.

<img width="1901" height="1025" alt="image" src="https://github.com/user-attachments/assets/e3ffa479-d47d-448d-8059-48b6aa0a2c33" />

### Polecenia Budowania
Podobnie jak w części obowiązkowej, do poprawnego pobrania zależności niezbędne było wymuszenie sieci hosta.

1. **Inicjalizacja zaawansowanego buildera:**
   `docker buildx create --name builder-chmura --driver docker-container --driver-opt network=host --use`
2. **Budowanie obrazu z cachem i wysyłką (push):**
   `docker buildx build --platform linux/amd64,linux/arm64 --ssh default --cache-to type=registry,ref=jedenastek/aplikacja_pogodowa_dod:cache,mode=max --cache-from type=registry,ref=jedenastek/aplikacja_pogodowa_dod:cache -t jedenastek/aplikacja_pogodowa_dod:1.0 --push .`

### Potwierdzenie Manifestu 
Weryfikacja posiadania dwóch platform sprzętowych w manifeście:
`docker buildx imagetools inspect jedenastek/aplikacja_pogodowa_dod:1.0`

### Zrzuty Ekranu
Znajdują sie w osobnym folderze w repozytorium
