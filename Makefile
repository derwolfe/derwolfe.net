S3_BUCKET=www.derwolfe.net
OUTPUTDIR=./_built

all: build

clean:
	rm -rf $(OUTPUTDIR)

build: clean css
	mynt gen $(OUTPUTDIR)

deploy: build
	s3cmd sync $(OUTPUTDIR)/ s3://$(S3_BUCKET) --acl-public --delete-removed

serve:
	twistd -n web --path $(OUTPUTDIR)

css:
	sass _assets/css/derwolfe.scss _assets/css/derwolfe.css

.PHONY:
	all clean build deploy serve css
