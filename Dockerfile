FROM ubuntu:21.10

ADD ./ /

RUN chmod 777 /so_load.sh
RUN apt -y update
RUN apt -y curl && apt -y install wget && apt -y install jq
RUN mkdir /work && mkdir /data

ENTRYPOINT [ "/so_load.sh" ]


