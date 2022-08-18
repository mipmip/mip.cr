run:
	crystal run src/mvi.cr -- ./README.md

all: test build

build:
	crystal build src/mvi.cr

test:
	crystal spec
clean:
	rm -f ./mvi
