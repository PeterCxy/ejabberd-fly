FROM docker.io/ejabberd/ecs:24.02

USER root

RUN apk add bind-tools bash

COPY entrypoint.sh /
COPY env.sh /
COPY ejabberd.yml /home/ejabberd/conf/

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
