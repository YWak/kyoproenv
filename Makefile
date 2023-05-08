IMAGE_NAME ?= ywak/kyoproenv

dev: dev-base dev-go

dev-base:
	docker build -t $(IMAGE_NAME):base ./src/base

dev-go:
	docker build -t $(IMAGE_NAME):golang ./src/golang
