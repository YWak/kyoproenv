#!/bin/bash

source ../lib.sh

IMAGE_NAME="kyoproenv-test-$(date +%s)"

_trap_push "docker rmi \$IMAGE_NAME || true" 0

docker build -q --build-arg SRC_IMAGE_NAME=${SRC_IMAGE_NAME:-ywak/kyoproenv:base} -t "$IMAGE_NAME" .

_it "provides oj" bash --login -c 'oj --version'

_show_results
