FROM ghcr.io/cirruslabs/flutter:3.41.2 AS builder

WORKDIR /app

RUN git config --global --add safe.directory '*'

COPY pubspec.yaml pubspec.lock ./
COPY packages ./packages

WORKDIR /app/packages/app
RUN flutter pub get
ARG API_URL
RUN flutter build web --release --dart-define=API_URL=${API_URL}

FROM caddy:2-alpine
COPY --from=builder /app/packages/app/build/web /srv
