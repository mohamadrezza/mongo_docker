FROM ubuntu:latest
MAINTAINER MohamadRezza
ENV MONGO_USER=mongodb \
    MONGO_DATA_DIR=/var/lib/mongodb \
    MONGO_LOG_DIR=/var/log/mongodb

RUN apt-get update
RUN apt-get install gnupg -y
RUN apt-get install curl -y
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc |  apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" |  tee 
/etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt update
RUN apt-cache policy libssl1.0-dev
RUN apt update
RUN echo "deb http://security.ubuntu.com/ubuntu impish-security main" |  tee 
/etc/apt/sources.list.d/impish-security.list

RUN apt-get update
RUN apt-get install libssl1.1
RUN apt-get -y install apt-utils
RUN apt-get update
RUN apt-get --fix-broken install
RUN apt-get -y install mongodb-org 
RUN chmod 777 -R /var/log/mongodb/

RUN chmod 777 -R /var/lib/mongodb/
RUN chmod 777 -R /var/lib/mongodb/

VOLUME ["/var/lib/mongodb"]

ADD mongod.conf /etc/mongodb.conf

EXPOSE 27017
CMD ["/usr/bin/mongod"]

