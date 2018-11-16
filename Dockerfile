FROM golang AS building

LABEL maintainer="jeferson@linuxtips.com.br"
LABEL version="2.0"

ENV blackbox_version 0.12.0

RUN curl -LO https://github.com/prometheus/blackbox_exporter/releases/download/v${blackbox_version}/blackbox_exporter-${blackbox_version}.linux-amd64.tar.gz \
    && tar -xvzf blackbox_exporter-${blackbox_version}.linux-amd64.tar.gz  \
    && cp blackbox_exporter-${blackbox_version}.linux-amd64/blackbox_exporter /tmp/

FROM alpine

COPY --from=building /tmp/blackbox_exporter /usr/local/bin/

ADD config/blackbox.yml /etc/blackbox_exporter/blackbox.yml

ENTRYPOINT /usr/local/bin/blackbox_exporter --config.file /etc/blackbox_exporter/blackbox.yml
