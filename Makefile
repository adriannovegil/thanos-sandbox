#
# Makefile to manage the containers.
# Author: Adrian Novegil <adrian.novegil@gmail.com>
#
.DEFAULT_GOAL:=help

PROJECT_NAME=observability-sandbox
DOCKER_NETWORK=observabilitysandbox
COMPOSE_COMMAND=docker-compose --project-name=$(PROJECT_NAME)

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
	@echo '    run                   Arranca todos los contenedores necesarios para ejecutar el sistema en modo demonio'
	@echo '    up                    build + run'
	@echo '    stop                  Para los contenedores'
	@echo '    down                  Elimina los contenedores'
	@echo '    restart               stop + run'
	@echo '    status                Recupera el estado de los contenedores'
	@echo ''
	@echo '  Clean Targets:'
	@echo '    clean-network         Borra la red Docker'
	@echo '    clean-images          Borra las imágenes creadas'
	@echo ''

create-network:
ifeq ($(shell docker network ls | grep ${DOCKER_NETWORK} | wc -l),0)
	echo "Creating docker network ${DOCKER_NETWORK}"
	@docker network create ${DOCKER_NETWORK}
endif

build:
	. ./env.sh; \
	$(COMPOSE_COMMAND) $${ALL_COMPOSE_FILES} build

run: create-network
	. ./env.sh; \
	$(COMPOSE_COMMAND) -f $${GRAFANA} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C1_R1} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C1_R2} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C1_OBJ_STORAGE} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C1_COMPACTOR} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C1_QUERIER} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C1_STORE} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C2_R1} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C2_R2} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C2_OBJ_STORAGE} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C2_COMPACTOR} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C2_QUERIER} up -d; \
	$(COMPOSE_COMMAND) -f $${PROMETHEUS_C2_STORE} up -d; \
	$(COMPOSE_COMMAND) -f $${THANOS_OBSERVER} up -d

up: build run-daemon

stop:
	. ./env.sh; \
	$(COMPOSE_COMMAND) $${ALL_COMPOSE_FILES} stop

down:
	. ./env.sh; \
	$(COMPOSE_COMMAND) $${ALL_COMPOSE_FILES} down

restart: stop run

status:
	. ./env.sh; \
	$(COMPOSE_COMMAND) $${ALL_COMPOSE_FILES} ps

clean-network:
	@docker network rm ${DOCKER_NETWORK} | true

clean-images:
	$(COMPOSE_COMMAND) down --rmi local | true
