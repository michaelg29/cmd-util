
# directories
OBJ_DIR=../obj
BIN_DIR=../bin

ifeq (,$(wildcard $(OBJ_DIR)))
$(error Object directory $(OBJ_DIR) does not exist, please create it)
endif
ifeq (,$(wildcard $(BIN_DIR)))
$(error Binary directory $(BIN_DIR) does not exist, please create it)
endif

# c flags
CXX=gcc
CFLAGS ?= -g3
IFLAGS ?= -I../include
LFLAGS ?= -L$(BIN_DIR)

# file lists
DEPS=$(wildcard *.h) $(wildcard ../include/*.h)
SRCS=$(wildcard *.c)
OBJS=$(SRCS:%.c=$(OBJ_DIR)/%.o)

all: $(OBJS) fp

# compile
$(OBJ_DIR)/%.o: %.c $(DEPS)
	$(CXX) -c -o $@ $< $(CFLAGS) $(IFLAGS)

# link
fp: $(OBJ_DIR)/fp.o $(OBJ_DIR)/text.o
	$(CXX) -o $(BIN_DIR)/$@ $^ $(CFLAGS) $(LFLAGS)

# clean
clean:
	$(RM) $(wildcard $(OBJ_DIR)/*.o) $(wildcard $(BIN_DIR)/*.exe)
