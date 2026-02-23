FROM ubuntu:24.04 AS builder

RUN apt-get update && apt-get install -y curl git unzip xz-utils clang cmake ninja-build pkg-config libgtk-3-dev && rm -rf /var/lib/apt/lists/*

RUN curl https://mise.run | sh
ENV PATH="/root/.local/bin:${PATH}"

WORKDIR /app

COPY mise.toml mise.lock ./
RUN mise install
ENV PATH="/root/.local/share/mise/shims:${PATH}"

COPY packages ./packages
COPY pubspec.yaml .
COPY pubspec.lock .

RUN flutter pub get

ARG API_URL
RUN flutter build web --release --dart-define=API_URL=${API_URL}

FROM caddy:2-alpine
COPY --from=builder /app/packages/app/build/web /srv
