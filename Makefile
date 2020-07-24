IMAGE = datashaman/phial-runtime
PHP_PACKAGE = php74

build: build-base build-php74

.PHONY: build-base
build-base:
	DOCKER_BUILDKIT=1 docker build -t $(IMAGE):build-base build-base

build-$(PHP_PACKAGE):
	DOCKER_BUILDKIT=1 docker build --build-arg PHP_PACKAGE=$(PHP_PACKAGE) -t $(IMAGE):build-$(PHP_PACKAGE) build-php

run-$(PHP_PACKAGE):
	docker run -it --rm -v $(HOME)/.aws:/root/.aws $(IMAGE):build-$(PHP_PACKAGE) bash
