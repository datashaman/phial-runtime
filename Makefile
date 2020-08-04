IMAGE = datashaman/phial-runtime

export DOCKER_BUILDKIT = 1
export PHP_PACKAGE = php74

build: build-base build-$(PHP_PACKAGE)

.PHONY: build-base
build-base:
	docker build -t $(IMAGE):build-base build-base

build-$(PHP_PACKAGE):
	docker build --build-arg PHP_PACKAGE -t $(IMAGE):build-$(PHP_PACKAGE) build-php

run-$(PHP_PACKAGE):
	docker run -it --rm -v $(HOME)/.aws:/root/.aws $(IMAGE):build-$(PHP_PACKAGE) bash
