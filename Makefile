CC ?= g++
target = DinguxCommander

RESDIR ?= /emuelec/configs/fm/res/
FILE_SYSTEM ?= /storage
PATH_DEFAULT ?= /media
PATH_DEFAULT_RIGHT ?= /storage/roms

# set variables for the OGA screen
ifeq ($(ODROIDGO), 1)
	SCREENW := 480
	SCREENH := 320
	FONTSIZE := 8
	HEADERH := 17
	H_PADDING_TOP := 3
	FOOTERH := 13
	F_PADDING_TOP := 1
	LINEH := 15
	FONTTOUSE := $(RESDIR)/Fiery_Turk.ttf
	VIEWER_LINE_H := 13
else
# todo detect resolution and set window to correct size
	SCREENW ?= 1920
	SCREENH ?= 1080
	FONTSIZE ?= 24
	HEADERH ?= 34
	H_PADDING_TOP ?= 6
	FOOTERH ?= 26
	F_PADDING_TOP ?= 2
	LINEH ?= 34
	FONTTOUSE ?= /usr/share/retroarch-assets/ozone/bold.ttf
	VIEWER_LINE_H ?= 26
endif


SRCS=$(wildcard ./*.cpp)
OBJS=$(patsubst %cpp,%o,$(SRCS))

#INCLUDE = -I/usr/include/SDL2
INCLUDE =  $(shell sdl2-config --cflags)
#LIB = -L/usr/lib -lSDL2 -lSDL2_image -lSDL2_ttf 
#LIB = -lSDL2 -lSDL2_image -lSDL2_ttf 
LIB = $(shell sdl2-config --libs) -lSDL2_image -lSDL2_ttf -lSDL2_gfx

all:$(OBJS)
	$(CC) $(OBJS) -o $(target) $(LIB)

%.o:%.cpp
	$(CC) -DRES_DIR="\"$(RESDIR)\"" -DODROID_GO_ADVANCE -DFILE_SYSTEM="\"$(FILE_SYSTEM)\"" -DFONT_SIZE=$(FONTSIZE) -DHEADER_H=$(HEADERH) -DHEADER_PADDING_TOP=$(H_PADDING_TOP) -DFOOTER_H=$(FOOTERH) -DFOOTER_PADDING_TOP=$(F_PADDING_TOP) -DLINE_HEIGHT=$(LINEH) -DPATH_DEFAULT="\"$(PATH_DEFAULT)\"" -DPATH_DEFAULT_RIGHT="\"$(PATH_DEFAULT_RIGHT)\"" -DFONT_TO_USE="\"$(FONTTOUSE)\"" -DVIEWER_LINE_HEIGHT=$(VIEWER_LINE_H) -c $< -o $@  $(INCLUDE) 

clean:
	rm $(OBJS) $(target) -f

