CI_REGISTRY_IMAGE  ?= registry.gitlab.com/frontistr-commons/frontistr_manual

TAG ?= latest

all: build

login:
ifeq ($(CI_BUILD_TOKEN),)
	docker login $(CI_REGISTRY_IMAGE)
else
	docker login -u gitlab-ci-token -p $(CI_BUILD_TOKEN) $(CI_REGISTRY_IMAGE)
endif

build:
	docker build \
		-t $(CI_REGISTRY_IMAGE)/build:$(TAG) \
		-f Dockerfile \
		--target build \
		.

push: login build
	docker push $(CI_REGISTRY_IMAGE)/build:$(TAG)


