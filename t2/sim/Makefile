all: all1 all2 all3 all4 all5
all1:  ngspice1.log
	#$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	#$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	#$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)

all2:  ngspice2.log
	#$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	#$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	#$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)

all3:  ngspice3.log
	#$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	#$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	#$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)

all4:  ngspice4.log
	#$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	#$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	#$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)

all5:  ngspice5.log
		#$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
		#$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
		#$(foreach i, $(NGSFIGPS), ps2pdf $i;)
		$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
		$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)


ngspice1.log : ../sim/t2.net
	ngspice -b $< -o $@

ngspice2.log: ../sim/t2-2.net
	ngspice -b $< -o $@

ngspice3.log : ../sim/t2-3.net
	ngspice -b $< -o $@

ngspice4.log : ../sim/t2-4.net
	ngspice -b $< -o $@

ngspice5.log : ../sim/t2-5.net
		ngspice -b $< -o $@

clean:
	@rm -f *.log *.tex *.pdf *.eps *.ps *~

.PHONY: all clean
