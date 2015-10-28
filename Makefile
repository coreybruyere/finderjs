npmBin = node_modules/.bin

.PHONY: install clean test cover lint watch

install:
	rm -rf node_modules/
	npm install

clean:
	rm -rf coverage/
	rm example/bundle.js
	rm -rf build/

test:
	$(npmBin)/tape test/**/*.js | $(npmBin)/tap-spec

cover:
	$(npmBin)/istanbul cover --report html test/test.js

lint:
	$(npmBin)/eslint *.js test/**

watch:
	$(npmBin)/watchify $(in) -d -v -o $(out)

build: clean
	$(npmBin)/browserify --no-builtins example/index.js -o example/bundle.js
	mkdir build
	$(npmBin)/browserify --full-paths --no-builtins --s finderjs -g uglifyify index.js -o build/finder.js
