# Trendyol Case2 Service Management
Bu çalışmada her bir servis için ayrı bir docker container kullanılmıştır. 
Hem container lifecycle yönetiminin kolay olması, hem de bağımlılık gereksinimini sağlamak için docker-compose ile tasarlanmıştır. 
Tengine, prometheus ve grafana servislerinin her biri ayrı bir container üzerinden hizmet vermektedir. 

Tengine :
tengine nginx kaynak kodundan inherit edilerek geliştirilmiş, web server, proxy, loadbalance çözümüdür. Bu projede reverse-proxy özelliği kullanılmıştır. 
centos8 container baz alınarak tengine source kodu gerekli modüller (nginx-module-vts) ile derlenerek oluşturulmuş custom bir imajdır. 
Docker-Hub üzerinde "yusufyazici/tengine-with-vts:v2" tag ile public olarak erişilebilir durumdadır.
80 ve 443 portlarından hizmet verebilir şekilde ayarlanmıştır. 

Prometheus:
prom/prometheus imajı baz alınmış, /etc/prometheus/prometheus.yml dosyasındaki target host "tengine" container olarak set edilmiştir.
9090 portundan hizmet vermektedir. 

    static_configs:
    - targets: ['tengine']

Grafana:

grafana/grafana docker imajı baz alınmış ve visualize edilmesi gerekli olan nginx_vts_server_requests_total ve
nginx_vts_upstream_response_seconds metrikleri container 3000 portu üzerinde admin konsola erişilerek yapılmıştır. 
Home -> Trendyol Dashboard oluşturulmuş ve ilgili metrikleri toplayan iki grafik eklenmiştir. 

Tüm bu değişikliklerin ve zamanla toplanan metrik, veri ve logların kalıcı olması için persistent volume kullanılmış ve ilgili containerlara ait değişen dosyalar lokal sistemdeki klasörlere map edilmiştir.
Böylece olası container restart edilmesi durumunda veri kaybının önüne geçilmiştir. 
