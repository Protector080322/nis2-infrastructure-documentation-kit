# Infrastructure Monitoring Stack (Docker)

This example demonstrates how to deploy a professional monitoring stack (Zabbix/Grafana) to satisfy NIS2 requirements for continuous observation.

## Architecture
- **VLAN:** 70 (Monitoring)
- **Host:** srv-monitoring-01
- **Services:** Zabbix Server, Zabbix Web Interface, PostgreSQL Database, Grafana Dashboard.

## Docker Compose File
```yaml
version: '3.8'

services:
  zabbix-db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: zabbix
      POSTGRES_USER: zabbix
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - ./data/db:/var/lib/postgresql/data
    networks:
      - monitoring-net

  zabbix-server:
    image: zabbix/zabbix-server-pgsql:6.4-alpine
    depends_on:
      - zabbix-db
    environment:
      DB_SERVER_HOST: zabbix-db
      POSTGRES_DB: zabbix
      POSTGRES_USER: zabbix
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    ports:
      - "10051:10051"
    networks:
      - monitoring-net

  zabbix-web:
    image: zabbix/zabbix-web-nginx-pgsql:6.4-alpine
    depends_on:
      - zabbix-server
    environment:
      ZBX_SERVER_HOST: zabbix-server
      DB_SERVER_HOST: zabbix-db
      POSTGRES_DB: zabbix
      POSTGRES_USER: zabbix
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      PHP_TZ: Europe/Berlin
    ports:
      - "8080:8080"
    networks:
      - monitoring-net

  grafana:
    image: grafana/grafana-oss:latest
    depends_on:
      - zabbix-web
    ports:
      - "3000:3000"
    volumes:
      - ./data/grafana:/var/lib/grafana
    networks:
      - monitoring-net

networks:
  monitoring-net:
    driver: bridge
```

## Setup Instructions
1. Create a `.env` file with a strong `DB_PASSWORD`.
2. Run `docker-compose up -d`.
3. Access Zabbix at `http://<host-ip>:8080` (default: Admin/zabbix).
4. Access Grafana at `http://<host-ip>:3000` (default: admin/admin).
5. Install the Zabbix plugin in Grafana to visualize your metrics.
