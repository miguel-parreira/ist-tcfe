octave.log: rc.m data
	octave $< > $@

data:
	cd .. && cp -a data.txt ./mat
# && cd mat && mv data.txt data.mat

clean:
	@rm -f octave.log octave-workspace *.eps *~

.PHONY: clean
