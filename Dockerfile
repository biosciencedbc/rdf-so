FROM centos

ADD ./ /

RUN chmod 777 /so_load.sh
RUN yum -y install wget && yum -y install jq
RUN mkdir /work && mkdir /data

ENTRYPOINT [ "/so_load.sh" ]


