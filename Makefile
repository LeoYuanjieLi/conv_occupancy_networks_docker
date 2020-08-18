NAME := cov_occupancy_network
version_file := ./VERSION
VERSION := $(shell cat ${version_file})

docker: Dockerfile VERSION
	docker build -t $(NAME):$(VERSION) .

run:
	docker run --name=jupy-conv_onet --rm -p 8888:8888 -v $(shell pwd)/app:/app $(NAME):$(VERSION)