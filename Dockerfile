FROM ubuntu:latest

COPY . recommendation

RUN apt-get update -y
RUN apt-get install -y swi-prolog
RUN apt-get install -y xauth

WORKDIR /recommendation/src
ENTRYPOINT ["swipl", "main.pl"]
