
all: octave.log

octave.log: t4.m
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.eps *~ tabela1.tex tabela2.tex

.PHONY: clean
