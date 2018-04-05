APP = app_template
LIB = libtemplate
CC = gcc
CFLAGS = -Wall -Wextra -fPIC
FTD2XX := ./libftd2xx-x86_64-1.4.6/build/libftd2xx.a

all: clean $(LIB) $(APP)

$(APP):
	$(CC) -o $(APP) $(CFLAGS) app_template.c ft_utils.c utils.c $(FTD2XX) -lpthread -lncursesw

$(LIB):
	$(CC) -shared -o $(LIB).so $(CFLAGS) library_template.c ft_utils.c utils.c $(FTD2XX) -lpthread -Wl,--version-script=lib.export -Wl,-rpath=. -Wl,-rpath=/usr/local/lib

clean:
	rm -f *.o;
	rm $(APP);
	rm $(LIB).so;
