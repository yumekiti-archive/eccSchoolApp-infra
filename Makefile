dc := docker-compose -f ./docker/docker-compose.yml

up:
	$(dc) up -d

down:
	$(dc) down

restart:
	$(dc) restart

reup:
	@make down
	@make up

rm:
	$(dc) down --rmi all

logs:
	$(dc) logs -f

api:
	$(dc) exec api /bin/sh

cache:
	$(dc) exec cache /bin/sh

web:
	$(dc) exec web /bin/sh

.PHONY:	setup up down restart reup rm logs api cache web