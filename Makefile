NAME = narra
VERSION = 0.0.1

.PHONY: all build_all \
	build_master build_worker \
	tag_latest release clean

all: build_all

build_all: build_master build_worker

# Docker doesn't support sharing files between different Dockerfiles. -_-
# So we copy things around.
build_master:
	rm -rf master_image
	cp -pR image master_image
	echo master=1 >> master_image/buildconfig
	docker build -t $(NAME)/master:$(VERSION) --rm master_image

build_worker:
	rm -rf worker_image
	cp -pR image worker_image
	echo worker=1 >> worker_image/buildconfig
	docker build -t $(NAME)/worker:$(VERSION) --rm worker_image

tag_latest:
	docker tag $(NAME)/master:$(VERSION) $(NAME)/master:latest
	docker tag $(NAME)/worker:$(VERSION) $(NAME)/worker:latest

release: tag_latest
	@if ! docker images $(NAME)/master | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)/master version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)/worker | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)/worker version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)/master
	docker push $(NAME)/worker
	@echo "*** Don't forget to create a tag. git tag $(VERSION) && git push origin $(VERSION)"

clean:
	rm -rf master_image
	rm -rf worker_image