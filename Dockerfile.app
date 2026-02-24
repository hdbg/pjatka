FROM ghcr.io/cirruslabs/flutter:3.29.3 AS builder

RUN git config --global --add safe.directory '*'

WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
COPY packages ./packages

WORKDIR /app/packages/app
RUN flutter pub get
ARG API_URL
RUN flutter build web --release --dart-define=API_URL=${API_URL}

FROM caddy:2-alpine
COPY --from=builder /app/packages/app/build/web /srv
