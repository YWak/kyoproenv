#!/bin/bash

source ../lib.sh

IMAGE_NAME="kyoproenv-test-$(date +%s)"

trap 'docker rmi $IMAGE_NAME || true' 0

docker build -q --build-arg SRC_IMAGE_NAME=${SRC_IMAGE_NAME:-ywak/kyoproenv:cpp} -t "$IMAGE_NAME" .

_it "provides ACL" bash --login -c 'cpp20 acl.cpp && [ $(./a.out) = 2 ]'
_it "provides boost range" bash --login -c 'cpp20 boost_range.cpp && [ $(./a.out) = 6 ]'

_show_results
