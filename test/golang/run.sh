#!/bin/bash

source ../lib.sh

IMAGE_NAME="kyoproenv-test-$(date +%s)"

_trap_push "docker rmi \$IMAGE_NAME || true"

docker build -q --build-arg SRC_IMAGE_NAME=${SRC_IMAGE_NAME:-ywak/kyoproenv:golang} -t "$IMAGE_NAME" .

_it "provides gottani" bash --login -c '[ -n "$(which gottani)" ]'

_show_results
