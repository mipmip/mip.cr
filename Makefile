run:
	make compthemes
	rm -f .temp.html .temp.seed
	crystal run src/mvi.cr -- -v ./README.md

all: test build

compthemes:
	yarn run inliner themesrc/theme1/template-src.html | tail -n +3 | head -n -1 > asset/theme1/template.html

build:
	make compthemes
	crystal build --release src/mvi.cr

test:
	crystal spec
clean:
	rm -f ./mvi
