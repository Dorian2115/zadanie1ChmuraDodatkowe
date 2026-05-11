# syntax=docker/dockerfile:1.4
# Autor: Dominik Dlugolencki
FROM python:3.13-alpine AS builder

RUN apk add --no-cache git openssh-client
WORKDIR /app_code

RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh git clone git@github.com:Dorian2115/zadanie1Chmury.git .

WORKDIR /requirements
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --prefix=/requirements -r /app_code/requirements.txt

FROM python:3.13-alpine AS final

LABEL org.opencontainers.image.authors="Dominik Dlugolencki"
LABEL org.opencontainers.image.title="Aplikacja pogodowa"
LABEL org.opencontainers.image.version="1.0.0"

ENV PORT=8080
WORKDIR /app

COPY --from=builder /requirements /usr/local
COPY --from=builder /app_code/app.py .

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD wget -qO- http://127.0.0.1:${PORT}/health || exit 1

CMD ["python", "app.py"]
