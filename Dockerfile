FROM alpine:latest
LABEL maintainer="Bayu Adin H <bayu.adin.h@mail.ugm.ac.id>"
LABEL description="Redis with latest Alphine"

RUN apk add --update redis && \
    rm -rf /var/cache/apk/* && \
    mkdir /data && \
    mkdir /data/log && \
    chown -R redis:redis /data

COPY config/redis.conf /etc/redis.conf

RUN sed -i 's#logfile /var/log/redis/redis.log#logfile /data/log/redis.log#i' /etc/redis.conf && \ 
    sed -i 's#dir /var/lib/redis#dir /data#i' /etc/redis.conf

VOLUME ["/data"]
USER redis
EXPOSE 6379/tcp

ENTRYPOINT ["redis-server", "/etc/redis.conf"]