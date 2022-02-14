FROM ubuntu:22.04

ADD ./ /

RUN chmod 777 /so_load.sh
RUN apt update
RUN apt -y install curl && apt -y install wget && apt -y install jq
RUN mkdir /work && mkdir /data

ENTRYPOINT [ "/so_load.sh" ]


