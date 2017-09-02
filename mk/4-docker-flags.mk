
# SHELL needed?
SHELL = /bin/sh

# IMAGES
R_IMAGE        = benizar/rcabreve

# DOCKER
DOCKER              = docker
DOCKER_RUN          = $(DOCKER) run
DOCKER_RUN_OPTIONS  = --rm
DOCKER_RUN_WORKDIR  = --workdir /source
DOCKER_VOLUME       = --volume $(PWD):/source

# R
RSCRIPT             = --entrypoint Rscript
RUN_RSCRIPT = $(DOCKER_RUN) $(DOCKER_RUN_OPTIONS) \
	$(DOCKER_RUN_WORKDIR) \
	$(RSCRIPT) \
	$(DOCKER_VOLUME) \
	$(R_IMAGE) \
	$(RSCRIPT_OPTIONS)
