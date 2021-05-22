
all: octave.log octavesymb.log

octave.log: t4.m
	octave $< > $@

octavesymb.log: symb.m
	octave $< > $@

clean:
	@rm -f octave.log octavesymb.log valores_bode.txt octave-workspace *.eps *~

.PHONY: clean
