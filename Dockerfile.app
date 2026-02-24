FROM jdxcode/mise:latest AS builder

RUN git config --global --add safe.directory '*'

WORKDIR /app
COPY mise.toml mise.lock ./

ENV MISE_YES=1
ENV MISE_DATA_DIR=/home/flutter/.local/share/mise
ENV MISE_CACHE_DIR=/home/flutter/.cache/mise
RUN mise trust
RUN mise install flutter

COPY pubspec.yaml pubspec.lock ./
COPY packages ./packages

WORKDIR /app/packages/app
RUN mise exec flutter -- flutter pub get
ARG API_URL
RUN mise exec flutter -- flutter build web --wasm --release --dart-define=API_URL=${API_URL}

FROM caddy:alpine

RUN printf ':80 {\n\
    root * /srv\n\
    file_server\n\
    try_files {path} /index.html\n\
\n\
    header {\n\
        Cross-Origin-Embedder-Policy "credentialless"\n\
        Cross-Origin-Opener-Policy "same-origin"\n\
    }\n\
\n\
    @mjs path *.mjs\n\
    header @mjs Content-Type "text/javascript"\n\
\n\
    @wasm path *.wasm\n\
    header @wasm Content-Type "application/wasm"\n\
}\n' > /etc/caddy/Caddyfile

COPY --from=builder /app/packages/app/build/web /srv
