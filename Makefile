run:
	rm -f .temp.html
	crystal run src/mvi.cr -- ./README.md

all: test build

build:
	crystal build --release src/mvi.cr

test:
	crystal spec
clean:
	rm -f ./mvi
