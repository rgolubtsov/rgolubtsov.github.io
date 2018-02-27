#
# Makefile
# =============================================================================
# A Cup of Radicchio. Version 0.1
# =============================================================================
# A Cup of Radicchio: A personal website of a power looper,
#                                             skateboarder,
#                                      and software devver.
# =============================================================================
# Copyright (C) 2016-2018 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

LIB_DIR = lib
SRC_DIR = src

# Specify flags and other vars here.
HARP      = harp
HARPFLAGS = compile
CP        = cp
CPFLAGS   = -vf
RMFLAGS   = -vR

# Making the target.
$(LIB_DIR) $(SRC_DIR):
	$(HARP) $(HARPFLAGS) $(SRC_DIR) $(LIB_DIR)
	$(CP) $(CPFLAGS) $(LIB_DIR)/* $(LIB_DIR)/..

.PHONY: all clean

all: $(LIB_DIR)

clean:
	$(RM) $(RMFLAGS) $(LIB_DIR)

# vim:set nu et ts=4 sw=4:
