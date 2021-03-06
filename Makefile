GOFMT ?= gofmt "-s"
PACKAGES ?= $(shell go list ./... | grep -v /vendor/)
GOFILES := $(shell find . -name "*.go" -type f -not -path "./vendor/*")

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    CCFLAGS += -D LINUX
endif
ifeq ($(UNAME_S),Darwin)
    CCFLAGS += -D OSX
endif
UNAME_P := $(shell uname -p)
ifeq ($(UNAME_P),x86_64)
    CCFLAGS += -D AMD64
endif
ifneq ($(filter %86,$(UNAME_P)),)
    CCFLAGS += -D IA32
endif
ifneq ($(filter arm%,$(UNAME_P)),)
    CCFLAGS += -D ARM
endif


.PHONY: all
all: deps build test


.PHONY: deps
deps:
	@hash dep > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		go get -u github.com/golang/dep/cmd/dep; \
	fi
	dep ensure


.PHONY: build
build:
	go build


.PHONY: clean
clean:
	go clean


.PHONY: test
test:
	go test -v -covermode=count -coverprofile=coverage.out


.PHONY: fmt
fmt:
	$(GOFMT) -w $(GOFILES)


.PHONY: fmt-check
fmt-check:
	# get all go files and run go fmt on them
	@diff=$$($(GOFMT) -d $(GOFILES)); \
	if [ -n "$$diff" ]; then \
		echo "Please run 'make fmt' and commit the result:"; \
		echo "$${diff}"; \
		exit 1; \
	fi;


.PHONY: vet
vet:
	go vet $(PACKAGES)


.PHONY: lint
lint:
	@hash golint > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		go get -u github.com/golang/lint/golint; \
	fi
	for PKG in $(PACKAGES); do golint -set_exit_status $$PKG || exit 1; done;


.PHONY: misspell-check
misspell-check:
	@hash misspell > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		go get -u github.com/client9/misspell/cmd/misspell; \
	fi
	misspell -error $(GOFILES)


.PHONY: misspell
misspell:
	@hash misspell > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		go get -u github.com/client9/misspell/cmd/misspell; \
	fi
	misspell -w $(GOFILES)


.PHONY: embedmd
embedmd:
	embedmd -d *.md
