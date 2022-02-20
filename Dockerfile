FROM golang

ARG REPO='github.com/drone/drone'
ARG VERSION
ENV DRONE_DATABASE_DATASOURCE=/data/database.sqlite

RUN git clone "https://${REPO}" drone/
WORKDIR drone/
RUN git checkout "v${VERSION}"

RUN go build -ldflags '-extldflags "-static"' -o /usr/local/bin/drone-server "${REPO}/cmd/drone-server"

ENTRYPOINT ["/usr/local/bin/drone-server"]
