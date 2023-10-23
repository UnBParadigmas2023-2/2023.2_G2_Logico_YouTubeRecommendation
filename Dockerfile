FROM ubuntu:latest

COPY .

RUN apt-get update -y
RUN apt-get install -y swi-prolog

WORKDIR /src
ENTRYPOINT ["swipl", "main.pl"]
