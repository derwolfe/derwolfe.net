S3_BUCKET=derwolfe.net
OUTPUTDIR=./_built

all: build

clean:
	rm -rf $(OUTPUTDIR)

build: clean
	mynt gen $(OUTPUTDIR)

serve:
	twistd -n web --path $(OUTPUTDIR)

zipit:
	find $(OUTPUTDIR) \( -iname '*.html' -o -iname '*.css' -o -iname '*.js' \) -exec gzip -9 -n {} \; -exec mv {}.gz {} \;

# zipping should only happen on css, html, js files; to be effective these need
# to be have the gzip header set.

deploy: build zipit
	s3cmd sync  s3://$(S3_BUCKET) --acl-public --delete-removed --add-header='Content-Encoding: gzip' --exclude="*.xml" --include="$(OUTPUTDIR)/"
	s3cmd sync --include="$(OUTPUTDIR)/feed.xml" s3://$(S3_BUCKET) --acl-public --delete-removed
