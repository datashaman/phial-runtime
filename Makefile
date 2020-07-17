IMAGE = datashaman/phial-runtime

build-php74:
	docker build --build-arg PHP_PACKAGE=php74 -t $(IMAGE):build-php-7.4 .

run-php74:
	docker run -it --rm -v $(HOME)/.aws:/root/.aws $(IMAGE):build-php-7.4 bash
