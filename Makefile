S3_BUCKET=derwolfe.net
OUTPUTDIR=./_built

all: build

clean:
	rm -rf $(OUTPUTDIR)

build: clean
	mynt gen $(OUTPUTDIR)

deploy: build
	s3cmd sync $(OUTPUTDIR)/ s3://$(S3_BUCKET) --acl-public --delete-removed

serve:
	twistd -n web --path $(OUTPUTDIR)
