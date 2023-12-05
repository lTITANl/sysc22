SRCS_static = static_main.c 
SRCS_dynamic = dll.c
LIBSRCS = open.c close.c set.c get.c 
TARG_static = kvs_static
TARG_dynamic = kvs_dynamic

CC = gcc
OPTS = -Wall -g
LIBS = -L. -lkvs

OBJS_static = $(SRCS_static:.c=.o)
OBJS_dynamic = $(SRCS_dynamic:.c=.o)
LOBJS = $(LIBSRCS:.c=.o)
LARS = libkvs.a
LARD = libkvs.so


all: static dynamic

static: $(TARG_static)

dynamic : $(TARG_dynamic)

$(TARG_static) : $(OBJS_static) $(LARS)
   $(CC) -o $(TARG_static) $(OBJS_static) $(LIBS) 

$(TARG_dynamic) : $(OBJS_dynamic) $(LARD)
   $(CC) -o $(TARG_dynamic) $(OBJS_dynamic) -ldl

$(LARS) : $(LOBJS)
   ar rs $(LARS) $(LOBJS)

$(LARD) : $(LOBJS)
   $(CC) -shared -fPIC -o $(LARD) $(LOBJS)

static_main.o: static_main.c
   $(CC) $(OPTS) -c $< -o $@

dll.o: dll.c
   $(CC) $(OPTS) -c $< -o $@

%.o: %.c
   $(CC) $(OPTS) -c $< -o $@

clean:
   rm -f $(OBJS_static) $(OBJS_dynamic) $(LOBJS) $(LARS) $(LARD) $(TARG_static) $(TARG_dynamic) 

run_dynamic : dynamic
   LD_LIBRARY_PATH = $(LD_LIBRARY_PATH):. ./$(TARG_dynamic)
