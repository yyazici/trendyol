#!/bin/bash

#Prometheus container erisimi icin gerekli izinler verilir.

sudo chown -R  65534:65534 prometheus/

#Garafana container erisimi icin gerekli yetkiler verilir.

sudo chown -R 472:472 grafana/

#docker-compose ile sistemler ayaga kaldirilir.

sudo docker-compose up

