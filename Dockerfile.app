FROM ubuntu:24.04 AS builder

RUN apt-get update && apt-get install -y curl git unzip xz-utils clang cmake ninja-build pkg-config libgtk-3-dev jq && rm -rf /var/lib/apt/lists/*

RUN curl https://mise.run | sh
ENV PATH="/root/.local/bin:${PATH}"

WORKDIR /app

COPY mise.toml mise.lock ./
ENV MISE_YES=1
RUN mise trust && mise install flutter

RUN git config --global --add safe.directory '*'

COPY pubspec.yaml pubspec.lock ./
COPY packages ./packages

WORKDIR /app/packages/app
RUN mise exec flutter -- flutter pub get
ARG API_URL
RUN mise exec flutter -- flutter build web --release --dart-define=API_URL=${API_URL}

FROM caddy:2-alpine
COPY --from=builder /app/packages/app/build/web /srv
