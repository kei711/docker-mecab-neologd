
.PHONY: run
run:
	docker container run -it kei711/mecab-neologd:latest

.PHONY: build
build:
	docker image build -t kei711/mecab-neologd:latest .


