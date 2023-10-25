XORG_CONFIG = --net=host --env="DISPLAY" --volume="${HOME}/.Xauthority:/root/.Xauthority:rw"

build:
	docker build . -t recommendation

run:
	docker run -it ${XORG_CONFIG} --rm --name recommendation recommendation