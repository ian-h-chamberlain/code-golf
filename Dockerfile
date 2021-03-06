FROM golang:1.15.2-alpine3.12

ENV CGO_ENABLED=0 GOPATH=

RUN apk add --no-cache build-base linux-headers tzdata

COPY go.mod go.sum ./

RUN go mod download

COPY . ./

RUN go build -ldflags -s \
 && gcc -Wall -Werror -Wextra -o /usr/bin/run-lang -s -static run-lang.c

RUN mkdir -p /rootfs/proc /rootfs/tmp

FROM scratch

COPY --from=codegolf/lang-bash       /       /langs/bash/rootfs/
COPY --from=codegolf/lang-brainfuck  /  /langs/brainfuck/rootfs/
COPY --from=codegolf/lang-c          /          /langs/c/rootfs/
COPY --from=codegolf/lang-c-sharp    /    /langs/c-sharp/rootfs/
COPY --from=codegolf/lang-cobol      /      /langs/cobol/rootfs/
COPY --from=codegolf/lang-f-sharp    /    /langs/f-sharp/rootfs/
COPY --from=codegolf/lang-fortran    /    /langs/fortran/rootfs/
COPY --from=codegolf/lang-go         /         /langs/go/rootfs/
COPY --from=codegolf/lang-haskell    /    /langs/haskell/rootfs/
COPY --from=codegolf/lang-j          /          /langs/j/rootfs/
COPY --from=codegolf/lang-java       /       /langs/java/rootfs/
COPY --from=codegolf/lang-javascript / /langs/javascript/rootfs/
COPY --from=codegolf/lang-julia      /      /langs/julia/rootfs/
COPY --from=codegolf/lang-lisp       /       /langs/lisp/rootfs/
COPY --from=codegolf/lang-lua        /        /langs/lua/rootfs/
COPY --from=codegolf/lang-nim        /        /langs/nim/rootfs/
COPY --from=codegolf/lang-perl       /       /langs/perl/rootfs/
COPY --from=codegolf/lang-php        /        /langs/php/rootfs/
COPY --from=codegolf/lang-powershell / /langs/powershell/rootfs/
COPY --from=codegolf/lang-python     /     /langs/python/rootfs/
COPY --from=codegolf/lang-raku       /       /langs/raku/rootfs/
COPY --from=codegolf/lang-ruby       /       /langs/ruby/rootfs/
COPY --from=codegolf/lang-rust       /       /langs/rust/rootfs/
COPY --from=codegolf/lang-sql        /        /langs/sql/rootfs/
COPY --from=codegolf/lang-swift      /      /langs/swift/rootfs/

COPY --from=0 /rootfs       /langs/bash/rootfs/
COPY --from=0 /rootfs  /langs/brainfuck/rootfs/
COPY --from=0 /rootfs          /langs/c/rootfs/
COPY --from=0 /rootfs    /langs/c-sharp/rootfs/
COPY --from=0 /rootfs      /langs/cobol/rootfs/
COPY --from=0 /rootfs    /langs/f-sharp/rootfs/
COPY --from=0 /rootfs    /langs/fortran/rootfs/
COPY --from=0 /rootfs         /langs/go/rootfs/
COPY --from=0 /rootfs    /langs/haskell/rootfs/
COPY --from=0 /rootfs          /langs/j/rootfs/
COPY --from=0 /rootfs       /langs/java/rootfs/
COPY --from=0 /rootfs /langs/javascript/rootfs/
COPY --from=0 /rootfs      /langs/julia/rootfs/
COPY --from=0 /rootfs       /langs/lisp/rootfs/
COPY --from=0 /rootfs        /langs/lua/rootfs/
COPY --from=0 /rootfs        /langs/nim/rootfs/
COPY --from=0 /rootfs       /langs/perl/rootfs/
COPY --from=0 /rootfs        /langs/php/rootfs/
COPY --from=0 /rootfs /langs/powershell/rootfs/
COPY --from=0 /rootfs     /langs/python/rootfs/
COPY --from=0 /rootfs       /langs/raku/rootfs/
COPY --from=0 /rootfs       /langs/ruby/rootfs/
COPY --from=0 /rootfs       /langs/rust/rootfs/
COPY --from=0 /rootfs        /langs/sql/rootfs/
COPY --from=0 /rootfs      /langs/swift/rootfs/

COPY --from=0 /go/code-golf                      /
COPY          /*.toml                            /
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY          /public                            /public/
COPY --from=0 /usr/bin/run-lang                  /usr/bin/
COPY --from=0 /usr/share/zoneinfo                /usr/share/zoneinfo/
COPY          /views                             /views/

CMD ["/code-golf"]
