.PHONY: all build

all: build

build:
	@# go get github.com/peterbourgon/grender
	rm -rf ./static
	grender -target ./static
