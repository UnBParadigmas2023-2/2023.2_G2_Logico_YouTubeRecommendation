FROM ubuntu:latest

COPY . recommendation

RUN apt-get update -y
RUN apt-get install -y swi-prolog

WORKDIR /recommendation/src
ENTRYPOINT ["swipl", "main.pl"]
