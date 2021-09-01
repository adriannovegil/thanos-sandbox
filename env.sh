#!/bin/bash

DOCKER_COMPOSE_FILE_NAME="docker-compose.yml"

GRAFANA_FOLDER="grafana"
PROMETHEUS_FOLDER="prometheus"
OBSERVER_FOLDER="thanos-observer"

CLUSTER_01="cluster-01"
CLUSTER_02="cluster-02"

export GRAFANA="$GRAFANA_FOLDER/$DOCKER_COMPOSE_FILE_NAME"

export PROMETHEUS_C1_R1="$PROMETHEUS_FOLDER/$CLUSTER_01/$PROMETHEUS_FOLDER/r1/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C1_R2="$PROMETHEUS_FOLDER/$CLUSTER_01/$PROMETHEUS_FOLDER/r2/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C1_OBJ_STORAGE="$PROMETHEUS_FOLDER/$CLUSTER_01/thanos-object-store/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C1_COMPACTOR="$PROMETHEUS_FOLDER/$CLUSTER_01/thanos-compactor/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C1_QUERIER="$PROMETHEUS_FOLDER/$CLUSTER_01/thanos-querier/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C1_STORE="$PROMETHEUS_FOLDER/$CLUSTER_01/thanos-store/$DOCKER_COMPOSE_FILE_NAME"

export PROMETHEUS_C2_R1="$PROMETHEUS_FOLDER/$CLUSTER_02/$PROMETHEUS_FOLDER/r1/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C2_R2="$PROMETHEUS_FOLDER/$CLUSTER_02/$PROMETHEUS_FOLDER/r2/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C2_OBJ_STORAGE="$PROMETHEUS_FOLDER/$CLUSTER_02/thanos-object-store/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C2_COMPACTOR="$PROMETHEUS_FOLDER/$CLUSTER_02/thanos-compactor/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C2_QUERIER="$PROMETHEUS_FOLDER/$CLUSTER_02/thanos-querier/$DOCKER_COMPOSE_FILE_NAME"
export PROMETHEUS_C2_STORE="$PROMETHEUS_FOLDER/$CLUSTER_02/thanos-store/$DOCKER_COMPOSE_FILE_NAME"

export THANOS_OBSERVER="thanos-observer/$DOCKER_COMPOSE_FILE_NAME"

export ALL_COMPOSE_FILES=" -f "$GRAFANA\
" -f "$PROMETHEUS_C1_R1\
" -f "$PROMETHEUS_C1_R2\
" -f "$PROMETHEUS_C1_OBJ_STORAGE\
" -f "$PROMETHEUS_C1_COMPACTOR\
" -f "$PROMETHEUS_C1_QUERIER\
" -f "$PROMETHEUS_C1_STORE\
" -f "$PROMETHEUS_C2_R1\
" -f "$PROMETHEUS_C2_R2\
" -f "$PROMETHEUS_C2_OBJ_STORAGE\
" -f "$PROMETHEUS_C2_COMPACTOR\
" -f "$PROMETHEUS_C2_QUERIER\
" -f "$PROMETHEUS_C2_STORE