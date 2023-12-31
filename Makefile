get_container_name = $(lastword $(subst -, ,$1))
dc_bin := $(shell (command -v docker-compose) 2> /dev/null)
dc_env_bin = $(dc_bin)

base_image_tag = dev:latest

up:
	@$(dc_env_bin) up -d

down:
	@$(dc_bin) down


enter-%:
	@$(dc_bin) exec $(call get_container_name, $@) bash

enter: enter-php

rm-%:
	@$(dc_bin) rm -fs $(call get_container_name, $@)

rm: rm-app

logs-%:
	@$(dc_bin) logs --follow $(call get_container_name, $@)

build:
	@docker build -t $(base_image_tag) docker/

clear:
	@rm -r app/source/tmp/*



