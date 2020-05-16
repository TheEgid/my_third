.PHONY: docs clean;

build:
	docker-compose build

run:
	docker-compose up -d

stop:
	docker-compose down

ARCHI = "`dpkg --print-architecture`"

test: SHELL:=/bin/bash
test:
	if [ $(ARCHI) == 'armhf' ]; \
	then docker-compose --file docker-compose.test_standalone_chromePI.yml run --rm web; \
	docker-compose --file docker-compose.test_standalone_chromePI.yml down; \
	else docker-compose --file docker-compose.test_standalone_chrome.yml run --rm web; \
	docker-compose --file docker-compose.test_standalone_chrome.yml down; \
	fi

dockerclean:
	docker system prune -f
	docker system prune -f --volumes
