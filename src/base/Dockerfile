ARG \
    CPP_BOOST_VERSION="1.81.0" \
    PYPY3_VERSION="3.9-v7.3.11" \
    PYTHON3_VERSION="3.11.2"

FROM ubuntu:22.04 as boost

ARG CPP_BOOST_VERSION

RUN \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        libgmp3-dev \
        ; \
    BASENAME="boost_$(echo ${CPP_BOOST_VERSION} | sed 's/./_/g')"; \
    curl -sSL -O https://boostorg.jfrog.io/main/release/${CPP_BOOST_VERSION}/source/${BASENAME}.tar.gz; \
    tar xf ${BASENAME}.tar.gz; \
    rm -f ${BASENAME}.tar.gz; \
    cd ${BASENAME}; \
    ./bootstrap.sh --with-toolset=gcc --without-libraries=mpi,graph_parallel; \
    ./b2 toolset=gcc variant=release link=static runtime-link=static cxxflags="-std=c++20" stage

FROM ubuntu:22.04

ARG PYPY3_VERSION

ENV \
    LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"

RUN \
    # install things
    set -e; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        bzip2 \
        ca-certificates \
        curl \
        g++ \
        gcc \
        git \
        language-pack-ja \
        less \
        make \
        python3 \
        python3-pip \
        tzdata \
        sudo \
        unzip \
        # used by c++20
        g++-12 \
        libeigen3-dev=3.4.0-2ubuntu2 \
        libgmp3-dev \
        # used by python
        gfortran \
        libgeos-dev \
        liblapack-dev \
        libopenblas-dev \
        pkg-config \
        ; \
    update-locale LANG=ja_JP.utf8; \

    # install online judge
    mv /usr/bin/python3 /usr/bin/python; \
    mv /usr/bin/pip3 /usr/bin/pip; \
    python -m pip install online-judge-tools; \

    # add user
    useradd -m user -s /bin/bash; \
    echo "user:user" | chpasswd; \
    echo "%user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/user; \
    chmod 0440 /etc/sudoers.d/user; \
    mkdir /home/user/work; \
    chown user:user /home/user/work; \

    # install ACL
    mkdir /opt/ac-library; \
    curl -sSL -O https://github.com/atcoder/ac-library/releases/download/v1.4/ac-library.zip; \
    unzip ac-library.zip -d /opt/ac-library; \
    rm ac-library.zip; \

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
    ln -s /opt/pypy3/bin/pypy3 /usr/bin/pypy3; \
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
        git+https://github.com/not522/ac-library-python

VOLUME ["/home/user/work"]
CMD ["sleep", "infinity"]
