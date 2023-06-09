IMAGE_NAME ?= ywak/kyoproenv

dev: dev-base dev-cpp dev-py dev-cpppy dev-golang
test: test-base test-cpp

dev-base:
	docker build -t $(IMAGE_NAME):base ./src/base

dev-cpp:
	docker build -t $(IMAGE_NAME):cpp ./src/cpp

dev-py:
	docker build -t $(IMAGE_NAME):python --build-arg SRC_IMAGE_NAME=$(IMAGE_NAME):base ./src/python

dev-cpppy:
	docker build -t $(IMAGE_NAME):cpppy --build-arg SRC_IMAGE_NAME=$(IMAGE_NAME):cpp ./src/python

dev-golang:
	docker build -t $(IMAGE_NAME):golang ./src/golang

test-base: dev-base
	cd test/base && bash run.sh

test-cpp: dev-cpp
	cd test/cpp && bash run.sh

test-golang: dev-golang
	cd test/golang && bash run.sh
