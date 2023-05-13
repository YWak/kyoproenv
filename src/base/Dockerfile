FROM ubuntu:22.04

ENV \
    LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"

RUN \
    # install basic items
    set -e; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        language-pack-ja \
        less \
        make \
        python3 \
        python3-pip \
        tzdata \
        sudo \
        unzip \
        ; \
    update-locale LANG=ja_JP.utf8; \

    # add user
    useradd -m user -s /bin/bash; \
    echo "user:user" | chpasswd; \
    echo "%user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/user; \
    chmod 0440 /etc/sudoers.d/user; \
    mkdir /home/user/work; \
    chown -R user:user /home/user

USER user

RUN \
    # install online judge
    python3 -m pip install online-judge-tools

VOLUME ["/home/user/work"]
CMD ["sleep", "infinity"]
