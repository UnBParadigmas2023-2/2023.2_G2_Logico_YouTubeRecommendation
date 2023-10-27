FROM ubuntu:latest

COPY . recommendation

RUN apt-get update -y && apt-get install -y swi-prolog && apt-get install -y xauth

WORKDIR /recommendation/src
ENTRYPOINT ["swipl", "main.pl"]
