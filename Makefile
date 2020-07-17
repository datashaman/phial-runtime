IMAGE = datashaman/phial-runtime

build-base:
	cd base && docker build -t $(IMAGE):build-base .

build-php74:
	cd php && docker build --build-arg PHP_PACKAGE=php74 -t $(IMAGE):build-php-74 .

run-php74:
	docker run -it --rm -v $(HOME)/.aws:/root/.aws $(IMAGE):build-php-74 bash
