octave.log: rc.m symbolic.log
	octave $< > $@

symbolic.log: symb.m data
	octave $< > $@

data:
	cd .. && cp -a data.txt ./mat

clean:
	@rm -f *.log octave-workspace *.eps *~ *.txt

.PHONY: clean
