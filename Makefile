#
# Makefile
# =============================================================================
# A Cup of Radicchio. Version 0.9.9
# -----------------------------------------------------------------------------
# A Cup of Radicchio: A personal website of a power looper,
#                                           a skateboarder,
#                                       and a coder.
# =============================================================================
# Copyright (C) 2016-2025 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

LIB_DIR = lib
SRC_DIR = src
DAT_DIR = data

# Specify flags and other vars here.
HARP    = harp
CP      = cp
CPFLAGS = -vRf
CD      = cd
LN      = ln
LNFLAGS = -sfn
RMFLAGS = -vR

# Making the target.
$(LIB_DIR) $(SRC_DIR):
	./utils/fitness-json-enumerate docs/stat/fitness.json
	./utils/ttennis-json-enumerate docs/stat/ttennis.json
	$(HARP) $(SRC_DIR) $(LIB_DIR)
	$(CP) $(CPFLAGS) $(LIB_DIR)/* $(LIB_DIR)/..
	$(CD) $(DAT_DIR)/docs/ubuntusrv                                    && \
	$(LN) $(LNFLAGS) ../../../utils/oracle-11-2-x-xe-set-kernel-params && \
	$(CD) -
	./utils/html-emoji-preproc  $(DAT_DIR)
	./utils/html-lang-preproc ./$(DAT_DIR)/
	./utils/http-404-preproc

.PHONY: all clean

all: $(LIB_DIR)

clean:
	$(RM) $(RMFLAGS) $(LIB_DIR) $(DAT_DIR)

# vim:set nu ts=4 sw=4:
