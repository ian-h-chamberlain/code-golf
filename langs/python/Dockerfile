FROM alpine:3.12 as builder

RUN apk add --no-cache build-base curl libffi-dev zlib-dev

RUN curl https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tar.xz \
  | tar xJf -

RUN cd Python-3.9.0       \
 && ./configure           \
    --prefix=/usr         \
    --with-lto            \
 && make -j`proc` install \
 && strip /usr/bin/python3.9

FROM scratch

COPY --from=0 /lib/ld-musl-x86_64.so.1 /lib/
COPY --from=0 /usr/bin/python3.9       /usr/bin/python
COPY --from=0 /usr/lib/python3.9       /usr/lib/python3.9

ENTRYPOINT ["/usr/bin/python", "-c", "import platform;print(platform.python_version())"]
