FROM ghcr.io/cirruslabs/flutter:3.38.6 AS builder

WORKDIR /app

COPY packages ./packages
COPY pubspec.yaml .
COPY pubspec.lock .

RUN flutter pub get

RUN dart compile exe packages/server/bin/server.dart -o server

FROM ubuntu:24.04 AS runner
WORKDIR /app

RUN apt-get update && apt-get install -y libssl-dev ca-certificates sqlite3 libsqlite3-dev && rm -rf /var/lib/apt/lists/* 

COPY --from=builder /app/server server

CMD [ "/app/server" ]