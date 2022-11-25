
# SHELL needed?
SHELL = /bin/sh

# IMAGES
R_IMAGE        = benizar/r-cabreve

# DOCKER
DOCKER              = docker
DOCKER_RUN          = $(DOCKER) run
DOCKER_RUN_OPTIONS  = --rm
DOCKER_RUN_WORKDIR  = --workdir /source
DOCKER_VOLUME       = --volume $(PWD):/source
DOCKER_USER         = -u $$(id -u):$$(id -g)

# R
RSCRIPT             = --entrypoint Rscript
RUN_RSCRIPT = $(DOCKER_RUN) $(DOCKER_RUN_OPTIONS) \
	$(DOCKER_RUN_WORKDIR) \
	$(RSCRIPT) \
	$(DOCKER_VOLUME) \
	$(DOCKER_USER) \
	$(R_IMAGE) \
	$(RSCRIPT_OPTIONS)
