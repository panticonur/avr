#SYSTEM = WINDOWS
APP = app_template
LIB = libtemplate
CC = gcc
CFLAGS = -Wall -Wextra -fPIC

ifeq ($(SYSTEM), WINDOWS)
	DEFINES = -DWINDOWS -D__USE_MINGW_ANSI_STDIO=1
	FTD2XX := ./windows/i386-2.12.28/ftd2xx.lib
all: $(APP)
else
	FTD2XX := ./linux/amd64-1.4.6/libftd2xx.a
	#DYNAMIC_DEPENDENCIES += -lrt
	DYNAMIC_LINK_OPTIONS := -Wl,--version-script=lib.export -Wl,-rpath=. -Wl,-rpath=/usr/local/lib
all: $(APP) $(LIB)
endif

$(APP):
	$(CC) -o $(APP) $(CFLAGS) $(DEFINES) app_template.c ft_utils.c utils.c $(FTD2XX) -lncursesw -lpthread

$(LIB):
	$(CC) -shared -o $(LIB).so $(CFLAGS) $(DEFINES) library_template.c ft_utils.c utils.c $(FTD2XX) -lpthread $(DYNAMIC_LINK_OPTIONS)

clean:
	rm -f *.o;
	rm $(APP);
	rm $(LIB).so;
