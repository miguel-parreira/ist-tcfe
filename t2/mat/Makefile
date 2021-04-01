octave.log: rc.m data.txt
	octave $< > $@

data.txt:
	cd .. && cp -a data.txt ./mat

clean:
	@rm -f octave.log octave-workspace *.eps *~

.PHONY: clean
