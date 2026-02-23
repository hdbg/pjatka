FROM jdxcode/mise:latest AS builder

WORKDIR /app

COPY mise.toml mise.lock ./
ENV MISE_YES=1
RUN mise trust
RUN mise install flutter 

RUN git config --global --add safe.directory '*'

COPY pubspec.yaml pubspec.lock ./
COPY packages ./packages

WORKDIR /app/packages/app
RUN mise exec flutter -- flutter pub get
ARG API_URL
RUN mise exec flutter -- flutter build web --release --dart-define=API_URL=${API_URL}

FROM caddy:2-alpine
COPY --from=builder /app/packages/app/build/web /srv
