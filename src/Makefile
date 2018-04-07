.PHONY: all clean build

all: build

clean:
	rm -rf ../index.html ../projects.html ../b/

build: clean
	@# go get github.com/peterbourgon/grender
	grender -source . -target ..
