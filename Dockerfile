ARG dart_version=3.7.2

FROM dart:${dart_version}

ENV PUB_HOSTED_URL="https://pub.dev"

WORKDIR /app

COPY ./unpub/ ./source

EXPOSE 4000

WORKDIR /app/source

RUN dart pub get && \
  dart compile aot-snapshot bin/unpub.dart && \
  cp bin/unpub.aot /app/unpub.aot && \
  rm -r /app/source

WORKDIR /app

# ENTRYPOINT [ "dart", "run", "bin/unpub.dart", "--database", "mongodb://unpub-mongo-service:27017/dart_pub"]
ENTRYPOINT [ "dartaotruntime", "unpub.aot", "--database", "mongodb://unpub-mongo-service:27017/dart_pub"]




