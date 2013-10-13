DIRS = $(sort $(dir $(wildcard */)))
SRCS = $(sort $(wildcard */*.erl))
OBJS = $(patsubst %.erl,%.beam,$(SRCS))


all: build

build: $(OBJS)

check: $(patsubst %.beam,%.check,$(OBJS))

clean:
	$(RM) $(OBJS)

distclean: clean
	git clean -fxd


%.beam: %.erl
	erlc -o $(dir $@) $<

%.check: %.beam
	erl -noshell -pa $(dir $*) -eval 'eunit:test('$(notdir $*)')' -s init stop


.PHONY: all build check clean distclean
