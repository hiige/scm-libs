PREFIX = /usr/local
LIBDIR = "$(PREFIX)/lib/scm"
LIBS = $(shell find . -mindepth 1 -maxdepth 1 -type d '!' -name '.*')

$(LIBS) :

all : $(LIBS)

install :
	cp -r $(LIBS) $(LIBDIR)
