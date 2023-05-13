ARG \
    PYTHON3_VERSION="3.11.2" \
    PYPY3_VERSION="3.9-v7.3.11" \
    SRC_IMAGE_NAME="ywak/kyoproenv:base"

FROM ubuntu:22.04 as python

ARG PYTHON3_VERSION

RUN \
    set -e; \
    # install deps
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    apt-get install -y \
        build-essential \
        curl \
        gdb \
        lcov \
        pkg-config \
        libbz2-dev \
        libffi-dev \
        libgdbm-dev \
        libgdbm-compat-dev \
        liblzma-dev \
        libncurses5-dev \
        libreadline6-dev \
        libsqlite3-dev \
        libssl-dev \
        lzma \
        lzma-dev \
        tk-dev \
        uuid-dev \
        zlib1g-dev \
        git \
        ; \
    curl -sSL -O \
        https://www.python.org/ftp/python/${PYTHON3_VERSION}/Python-${PYTHON3_VERSION}.tar.xz; \
    tar xf Python-${PYTHON3_VERSION}.tar.xz; \
    mv Python-${PYTHON3_VERSION} Python; \
    cd Python; \
    ./configure --enable-optimizations; \
    make;

FROM ${SRC_IMAGE_NAME}

ARG PYPY3_VERSION

USER user

COPY --from=python /Python /tmp/python

USER root
RUN \
    # install things
    set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        bzip2 \
        # used by python
        gfortran \
        libgeos-dev \
        liblapack-dev \
        libopenblas-dev \
        pkg-config \
        ; \

    # install python
    (cd /tmp/python && make altinstall); \
    rm -rf /tmp/python; \

    # install pypy3
    case $(arch) in \
        x86_64) PYPY3_ARCH="linux64" ;; \
        aarch64) PYPY3_ARCH="aarch64" ;; \
    esac; \
    PYPY3_BASE_NAME="pypy${PYPY3_VERSION}-${PYPY3_ARCH}"; \
    curl -sSL -O https://downloads.python.org/pypy/${PYPY3_BASE_NAME}.tar.bz2; \
    tar xf ${PYPY3_BASE_NAME}.tar.bz2; \
    rm -f ${PYPY3_BASE_NAME}.tar.bz2; \
    mv ${PYPY3_BASE_NAME} /opt/pypy3; \
    ln -s /opt/pypy3/bin/pypy3 /usr/local/bin/pypy3

USER user

RUN \
    python3.11 -m pip install -U setuptools==66.0.0; \
    python3.11 -m pip install \
        numpy==1.24.1 \
        scipy==1.10.1 \
        networkx==3.0 \
        sympy==1.11.1 \
        sortedcontainers==2.4.0  \
        more-itertools==9.0.0 \
        shapely==2.0.0 \
        bitarray==2.6.2 \
        PuLP==2.7.0 \
        mpmath==1.2.1 \
        pandas==1.5.2 \
        z3-solver==4.12.1.0 \
        scikit-learn==1.2.0 \
        ortools==9.5.2237 \
        torch==1.13.1 \
        polars==0.15.15 \
        lightgbm==3.3.1 \
        gmpy2==2.1.5 \
        numba==0.57.0rc1 \
        cppyy==2.4.1 \
        git+https://github.com/not522/ac-library-python \
        ; \
    python3.11 -m pip cache purge; \

    pypy3 -m ensurepip; \
    pypy3 -m pip install --upgrade pip; \
    pypy3 -m pip install \
        numpy==1.24.1 \
        scipy==1.10.1 \
        networkx==3.0 \
        sympy==1.11.1 \
        sortedcontainers==2.4.0  \
        more-itertools==9.0.0 \
        shapely==2.0.0 \
        bitarray==2.6.2 \
        PuLP==2.7.0 \
        mpmath==1.2.1 \
        pandas==1.5.2 \
        z3-solver==4.12.1.0 \
        scikit-learn==1.2.0 \
        typing-extensions==4.4.0 \
        cppyy==2.4.1 \
        git+https://github.com/not522/ac-library-python \
        ; \
    pypy3 -m pip cache purge
