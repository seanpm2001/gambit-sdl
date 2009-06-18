namespace = sdl\#
namespace_def = sdl\#.scm

.PHONY: all clean clean-generated build

do_make = for d in *.make ; do make -f $$d $${targ}; done

all: build ${namespace_def}

build:
	@targ=all; ${do_make}

${namespace_def}: ${shell ls *.scm | grep -v \#}
	cat $^ | scripts/make-gambit-include ${namespace} > $@

clean:
	@targ=$@; ${do_make}
	-rm -f ${namespace_def} 2>/dev/null

clean-generated:
	-rm -f *%.scm
