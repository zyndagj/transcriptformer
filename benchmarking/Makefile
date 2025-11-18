PTTAG ?= 25.10-py3
HUB_USER := gzynda
IMG := $(HUB_USER)/transcriptformer:pt$(PTTAG)

CURRENT_USER := -v /tmp/$(USER):/home/$(USER) -e HOME=/home/$(USER) -v /etc/passwd:/etc/passwd:ro --user $(shell id -u):$(shell id -g) -v /etc/group:/etc/group:ro -v /etc/shadow:/etc/shadow:ro -e USER=$(USER)
ifdef NV_GPU
	GPUS := --gpus \"device=$${NV_GPU}\" --ipc=host --ulimit memlock=-1 --ulimit stack=67108864
else
	GPUS := --gpus 1 --ipc=host --ulimit memlock=-1 --ulimit stack=67108864
endif
SHELL = /bin/bash
WSPACE := /tmp/$(USER)/workspace
DBDIR := /tmp/$(USER)/db
.ONESHELL:

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

build:
	cd $(mkfile_dir)/../../ && docker build -f transcriptformer/benchmarking/Dockerfile --build-arg PTTAG=$(PTTAG) -t $(IMG) .
push:
	docker push $(IMG)

/tmp/$(USER)/cache:
	mkdir -p $@

downloads: | /tmp/$(USER)/cache
	docker run --rm -it $(CURRENT_USER) $(IMG) transcriptformer download tf-sapiens --checkpoint-dir /home/$(USER)/cache

benchmark: | /tmp/$(USER)/cache/
	cp benchmark.sh /tmp/$(USER)/
	docker run --rm -it $(GPUS) $(CURRENT_USER) $(IMG) bash -c 'cd ~; bash benchmark.sh'
	rsync -ra /tmp/$(USER)/benchmark_logs ./

clean:
	rm -rf /tmp/$(USER)
