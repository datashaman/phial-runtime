TAG = builder

build:
	docker build -t $(TAG) .

run:
	docker run -it --rm -v $(HOME)/.aws:/root/.aws $(TAG) bash
