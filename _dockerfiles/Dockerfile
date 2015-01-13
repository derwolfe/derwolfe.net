FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl

RUN apt-get install -y build-essential
RUN apt-get install -y libssl-dev
RUN apt-get install -y libffi-dev
RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:pypy/ppa
RUN apt-get install -y pypy pypy-dev

RUN curl -L https://raw.github.com/pypa/pip/master/contrib/get-pip.py | pypy
RUN mkdir /config

ADD requirements.txt /config/requirements.txt

RUN cd /config; pip install -r requirements.txt

ADD server.tac /config/server.tac

VOLUME /site
VOLUME /keys

EXPOSE 8080
EXPOSE 4443

USER daemon

WORKDIR /tmp

CMD ["twistd", "--pidfile=", "-ny", "/config/server.tac"]