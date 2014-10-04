all: build

clean:
	rm -rf ./_built

build: clean
	mynt gen _built

serve:
	twistd -n web --path ./_built/
