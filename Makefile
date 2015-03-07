OUTPUTDIR=./_built
SSH_USER=web
SSH_PORT=2290
SSH_HOST=104.236.89.60
SSH_TARGET_DIR=/var/www/derwolfe.net/html/

.PHONY: clean build deploy rsync_upload serve

all: build serve

clean:
	rm -rf $(OUTPUTDIR)

build: clean
	mynt gen $(OUTPUTDIR)

deploy: build rsync_upload

rsync_upload:
	rsync -e "ssh -p $(SSH_PORT)" -P -rvz --delete $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

sshin:
	ssh -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST}

serve:
	twistd -n web --path $(OUTPUTDIR)
