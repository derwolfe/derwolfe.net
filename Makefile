all: build

clean:
	rm -rf ./_built

build: clean
	mynt gen _built
