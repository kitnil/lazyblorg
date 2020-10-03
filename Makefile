.PHONY: clean
build:
	docker build -t lazyblorg .

.PHONY: clean
clean:
	git clean -xdf

.PHONY: install
install:
	mkdir -p testdata/2del/blog
	$(shell guix build --no-offload -f guix.scm --without-tests=python-orgformat)/bin/lazyblorg --targetdir testdata/2del/blog --previous-metadata ./NONEXISTING_-_REPLACE_WITH_YOUR_PREVIOUS_METADATA_FILE.pk --new-metadata ./2del-metadata.pk --logfile ./2del-logfile.org --orgfiles testdata/end_to_end_test/orgfiles/about-placeholder.org templates/blog-format.org
	install --mode=644 templates/public_voit.css testdata/2del/blog
	mkdir -p testdata/2del/blog/images
	cp $(HOME)/majordomo/hms/frontend-app/public/images/icons/ruby.svg $(PWD)/testdata/2del/blog/images/public-voit_logo.svg

.PHONY: guix
guix:
	guix build -f guix.scm --no-offload --without-tests=python-orgformat
