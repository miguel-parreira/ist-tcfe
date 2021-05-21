all: ngspice.log ngspicestage1.log ngspicezout.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2eps -B $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)

ngspice.log: ../sim/t4.net
	ngspice -b $< -o $@

ngspicestage1.log: ../sim/stage1.net
	ngspice -b $< -o $@

ngspicezout.log: ../sim/zout.net
	ngspice -b $< -o $@

clean:
	@rm -f *.log *.tex *.pdf *.ps *~ *.eps

.PHONY: all clean
