FROM golang

ARG REPO='github.com/drone/drone'
ARG VERSION
EXPOSE 80
VOLUME /data

# These environment variables are copied from the upstream Dockerfiles in https://github.com/harness/drone.
ENV GODEBUG netdns=go
ENV XDG_CACHE_HOME /data
ENV DRONE_DATABASE_DRIVER sqlite3
ENV DRONE_DATABASE_DATASOURCE /data/database.sqlite
ENV DRONE_RUNNER_OS=linux
ENV DRONE_RUNNER_ARCH=amd64
ENV DRONE_SERVER_PORT=:80
ENV DRONE_SERVER_HOST=localhost

RUN git clone "https://${REPO}" drone/
WORKDIR drone/
RUN git checkout "v${VERSION}"

RUN go build -tags "nolimit" -o /usr/local/bin/drone-server "${REPO}/cmd/drone-server"

ENTRYPOINT ["/usr/local/bin/drone-server"]
