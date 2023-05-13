FROM ywak/kyoproenv:base

ARG \
    GOLANG_VERSION="1.20.3"

USER root
RUN \
    set -e; \
    case $(uname -m) in \
        x86_64)  GOLANG_ARCH="amd64" ;; \
        aarch64) GOLANG_ARCH="arm64" ;; \
        *) exit 1 ;; \
    esac; \
    GOLANG_BASE_NAME="go${GOLANG_VERSION}.linux-${GOLANG_ARCH}"; \
    GOLANG_ARCHIVE_NAME="${GOLANG_BASE_NAME}.tar.gz"; \
    curl -sSL -O https://go.dev/dl/${GOLANG_ARCHIVE_NAME}; \
    tar xf ${GOLANG_ARCHIVE_NAME}; \
    rm -f ${GOLANG_ARCHIVE_NAME}; \
    mv ./go /opt; \
    ln -s /opt/go/bin/go /usr/bin/go

USER user
RUN \
    go install github.com/ktateish/gottani/cmd/gottani@latest; \
    echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.profile
