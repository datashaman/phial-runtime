IMAGE = datashaman/phial-runtime

build: build-base build-php74

.PHONY: build-base
build-base:
	DOCKER_BUILDKIT=1 docker build -t $(IMAGE):build-base build-base

build-php74:
	DOCKER_BUILDKIT=1 docker build --build-arg PHP_PACKAGE=php74 -t $(IMAGE):build-php-74 build-php

run-php74:
	docker run -it --rm -v $(HOME)/.aws:/root/.aws $(IMAGE):build-php-74 bash
