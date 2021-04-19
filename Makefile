APP := api-tester
IMAGE := gcr.io/dronedeploy-code-delivery-0/$(APP)
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
GIT_HASH := $(shell git rev-parse --short HEAD)

LOCAL_OPTS := \
	-e PIPELINE_KEY=$(PIPELINE_KEY) \
	-v $(CURDIR/tests):/home/k6/tests

help:
	- @echo "package: build and label the latest docker image"
	- @echo "local: tag the latest image for local development and testing"
	- @echo "push: push the latest docker image to the container registry"
	- @echo "bash-local: run a shell in the docker image with the local workspace mounted"

package:
	- @echo "Creating and tagging docker image"
	docker build --target $(APP) --pull --build-arg GIT_HASH=$(GIT_HASH) --tag $(IMAGE):$(GIT_HASH) .
	docker tag $(IMAGE):$(GIT_HASH) $(IMAGE):$(GIT_BRANCH)

local: package
	- @echo "Tagging docker image for local development and testing"
	docker tag $(IMAGE):$(GIT_HASH) $(IMAGE):local

push:
	- @echo "Pushing tagged docker images to the container registry"
	docker push $(IMAGE):$(GIT_HASH)
	docker push $(IMAGE):$(GIT_BRANCH)

bash-local:
	- @echo "Shelling into the docker container with local workspace mounted"
	docker run -it --rm $(LOCAL_OPTS) $(IMAGE):local bash

run-local:
	- @echo "Running k6 tests from mounted local workspace"
	docker run -it --rm $(LOCAL_OPTS) $(IMAGE):local
