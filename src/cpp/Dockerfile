ARG \
    CPP_BOOST_VERSION="1.81.0" \
    SRC_IMAGE_NAME="ywak/kyoproenv:base"

FROM ubuntu:22.04 as boost

ARG CPP_BOOST_VERSION

RUN \
    BOOST_BASENAME="boost_$(echo ${CPP_BOOST_VERSION} | sed 's/\./_/g')"; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        libgmp3-dev \
        libpython3-dev \
        ; \
    curl -sSL -O https://boostorg.jfrog.io/artifactory/main/release/${CPP_BOOST_VERSION}/source/${BOOST_BASENAME}.tar.gz; \
    tar xf ${BOOST_BASENAME}.tar.gz; \
    rm -f ${BOOST_BASENAME}.tar.gz; \
    mv /${BOOST_BASENAME} /boost; \
    cd /boost; \
    ./bootstrap.sh --with-toolset=gcc --without-libraries=mpi,graph_parallel; \
    ./b2 toolset=gcc variant=release link=static runtime-link=static cxxflags="-std=c++20" stage

FROM ${SRC_IMAGE_NAME}

USER root

COPY ./cpp20.sh /home/user/.local/lib/cpp20.sh
COPY --from=boost /boost /tmp/boost

RUN \
    # install things
    set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        gcc \
        g++ \
        g++-12 \
        libeigen3-dev=3.4.0-2ubuntu2 \
        libgmp3-dev \
        libpython3-dev \
        ; \

    # enable cpp20 command
    chmod +x /home/user/.local/lib/cpp20.sh; \
    ln -s /home/user/.local/lib/cpp20.sh /home/user/.local/bin/cpp20; \

    # install ACL
    mkdir /opt/ac-library; \
    curl -sSL -O https://github.com/atcoder/ac-library/releases/download/v1.4/ac-library.zip; \
    unzip -q ac-library.zip -d /opt/ac-library; \
    rm -f ac-library.zip; \

    # install boost
    cd /tmp/boost; \
    ./b2 toolset=gcc variant=release link=static runtime-link=static cxxflags="-std=c++20" --prefix=/opt/boost/gcc install; \
    cd /home/user/work; \
    rm -rf /tmp/boost

USER user
