# Observability Sandbox

Get up and running with Prometheus, Thanos, Grafana, and more using Docker and Docker Compose

## Fast Run

Clone this repo and execute the following command:

´´´
make up
´´´

## Services

The following services will be started. Some are accessible via web:

| Component                  | Description                                                   | Port                          |
| -----------------------    | ------------------------------------------------------        | ----------------------------- |
| prometheus-1               | Prometheus Server 1 (labels: cluster=cluster-01, replica=r1)  | 9081                          |
| prometheus-2               | Prometheus Server 2 (labels: cluster=cluster-01, replica=r2)  | 9082                          |
| prometheus-3               | Prometheus Server 3 (labels: cluster=cluster-02, replica=r1)  | 9083                          |
| prometheus-4               | Prometheus Server 4 (labels: cluster=cluster-02, replica=r2)  | 9084                          |
| thanos-sidecar-1           | Thanos Sidecar for Prometheus Server 1                        | not accessible via browser    |
| thanos-sidecar-2           | Thanos Sidecar for Prometheus Server 2                        | not accessible via browser    |
| thanos-sidecar-3           | Thanos Sidecar for Prometheus Server 3                        | not accessible via browser    |
| thanos-sidecar-4           | Thanos Sidecar for Prometheus Server 4                        | not accessible via browser    |
