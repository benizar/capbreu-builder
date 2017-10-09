
# Include ordered mks
mks := $(sort $(wildcard mk/*.mk))
include $(mks)

#-------------------------------------
# BUILDS
#-------------------------------------
## Build all files and outputs from the begining
all: conjeture nodes edges visnetworks

## Create a new project structure, namely conjeture.
conjeture: $(dirs) $(project_data)

## Recreate HTML visNetworks (with varying node positions each iteration).
visnetworks: clean-visnetworks $(visnetwork_targets)

#-------------------------------------
# OUTPUTS
#-------------------------------------
## Conjeture is false. Move the current conjeture to the disproofs folder.
disproof: $(disproofs_dir)

## Conjeture is undecidable. Move the current conjeture to the undecidable conjetures folder.
undecidable: $(undecidables_dir)

## Conjeture has to be true, but it is not proven with this data. Move the current conjeture to the hypotheses folder.
hypothesis: $(hypotheses_dir)

## Conjeture is true. Move the current conjeture to the proofs folder.
proof: $(proofs_dir)

#-------------------------------------
# CLEANS
#-------------------------------------
.PHONY: clean
## Clean everything that was created using this Makefile.
clean:
	@echo ''
	@echo 'Cleaning project ...'
	@$(RM) -rf $(builds_dir) $(outputs_dir)
	@echo 'Removed everything that was created using this Makefile.'
	@echo ''

.PHONY: clean-visnetworks
## Clean visnetworks that were created using this Makefile.
clean-visnetworks:
	@echo ''
	@echo 'Cleaning visNetworks ...'
	@$(RM) -rf $(visnetwork_targets)
	@echo 'Removed visNetworks created by this Makefile.'
	@echo ''
