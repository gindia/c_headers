CC := gcc

SANITIZE:=-fsanitize=bounds -fsanitize=enum -fsanitize=signed-integer-overflow -fsanitize=null -fsanitize=signed-integer-overflow -fsanitize=return -fsanitize=integer-divide-by-zero -fsanitize=unreachable -fsanitize=alignment -fsanitize=address
CFLAGS:=$(SANITIZE) -DDEBUG -O0 -g -fno-exceptions -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable

EXE    :=linux_platform_layer_example

LIBS   :=-lSDL2 -lGLESv2 -lm

SRC_C  :=main.c \
		 linux.c

SRC_CPP:=

OBJ_C   :=$(patsubst %.c,   %.o, $(SRC_C))
OBJ_CPP :=$(patsubst %.cpp, %.o, $(SRC_CPP))

build: $(EXE) $(OBJ_C) $(OBJ_CPP)

rebuild: clean build

%.o: %.c %.h
	@mkdir -p bin
	@echo -e "Compiling $<"
	@$(CC) -c -o $@ $< $(CFLAGS)

%.o: %.cpp %.hpp
	@mkdir -p bin
	@echo -e "Compiling $<"
	@$(CC) -c -o $@ $< $(CFLAGS)

$(EXE): $(OBJ_C) $(OBJ_CPP)
	@mkdir -p bin
	@$(CC) -o bin/$(EXE) $(OBJ_C) $(OBJ_CPP) $(LIBS) $(CFLAGS)
	@echo -e "Done"


.PHONY: run build

run:
	@./bin/$(EXE)

clean:
	@echo -e "Deleting *.o   ..."
	@rm *.o -fr
	@echo -e "Deleting bin/* ..."
	@rm bin/* -fr
