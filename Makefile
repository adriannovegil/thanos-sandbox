#
# Makefile to manage the containers.
# Author: Adrian Novegil <adrian.novegil@gmail.com>
#
.DEFAULT_GOAL:=help
IMAGE_PREFIX=hdr
DOCKER_NETWORK=observabilitysandbox

# show some help
help:
	@echo ''
	@echo '  Usage:'
	@echo '    make <target>'
	@echo ''
	@echo '  Targets:'
	@echo '    help                  This information'
	@echo ''
	@echo '  Common Targets:'
	@echo '    create-network        Crea la red de Docker para los contenedores'
	@echo '    build                 Construye todas las imágenes a partir de los Dockerfiles'
	@echo '    run                   Arranca todos los contenedores necesarios para ejecutar el sistema'
	@echo '    run-daemon            run en modo daemon'
	@echo '    up                    build + run'
	@echo '    up-daemon             build + run-daemon'
	@echo '    stop                  Para los contenedores'
	@echo '    down                  Elimina los contenedores'
	@echo '    restart               stop + run'
	@echo '    status                Recupera el estado de los contenedores'
	@echo ''
	@echo '  Clean Targets:'
	@echo '    clean-network         Borra la red Docker'
	@echo '    clean-images          Borra las imágenes creadas'
	@echo '    clean-orphan-volumes  Elimina los volúmenes huérfanos'
	@echo '    clean-orphan-images   Elimina las imágenes huérfanas'
	@echo '    clean-all-images      Elimina todas las imágenes'
	@echo '    clean-all-containers  Elimina todos los containers'
	@echo '    clean-all-volumes     Elimina todos los volúmenes'
	@echo '    clean-all-networks    Elimina todas las redes'
	@echo '    prune                 Remove all stopped containers, all dangling images, and all unused networks'
	@echo ''

create-network:
ifeq ($(shell docker network ls | grep ${DOCKER_NETWORK} | wc -l),0)
	echo "Creating docker network ${DOCKER_NETWORK}"
	@docker network create ${DOCKER_NETWORK}
endif

build:
	@docker-compose -p ${IMAGE_PREFIX} build

run: create-network
	@docker-compose -p ${IMAGE_PREFIX} up

run-daemon: create-network
	@docker-compose -p ${IMAGE_PREFIX} up -d

up: build run

up-daemon: build run-daemon

stop:
	@docker-compose -p ${IMAGE_PREFIX} stop

down:
	@docker-compose -p ${IMAGE_PREFIX} down

restart: stop run

status:
	@docker-compose -p ${IMAGE_PREFIX} ps

clean-network:
	@docker network rm ${DOCKER_NETWORK} | true

clean-images:
	@docker-compose -p ${IMAGE_PREFIX} down --rmi local | true

clean-orphan-volumes:
	@docker volume rm $$(docker volume ls -q --filter dangling=true) | true

clean-orphan-images:
	@docker rmi $$(docker images --quiet --filter "dangling=true") | true

clean-all-images:
	@docker rmi -f $$(docker images) | true

clean-all-containers:
	@docker rm -f $$(docker ps -a -q) | true

clean-all-volumes:
	@docker volume rm $$(docker volume ls -q)

clean-all-networks:
	@docker network rm $$(docker network ls) | true

prune:
	@docker system prune
