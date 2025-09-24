.PHONY: build update-scripts validate

build:
	packer build marketplace-image.json

validate:
	packer validate marketplace-image.json

update-scripts:
	curl -o scripts/999-img-check.sh https://raw.githubusercontent.com/digitalocean/marketplace-partners/master/scripts/99-img-check.sh
	curl -o scripts/900-cleanup.sh https://raw.githubusercontent.com/digitalocean/marketplace-partners/master/scripts/90-cleanup.sh
