# ---------------------------------------------------------
# type the "make" command to create report.pdf
# ---------------------------------------------------------

#doc name
FILE=report

#list of LibreOffice Draw files
LODFIGS = $(patsubst %.odg,%.pdf,$(wildcard *.odg))

all: $(FILE).pdf
	evince $< &

$(FILE).pdf: $(wildcard *.tex) $(LODFIGS) data
	#cp -f ../mat/*.eps .
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex


#convert libreoffice draw figures to pdf
%.pdf: %.odg
	soffice --headless --convert-to pdf $<

data:
		cd ../mat && cp -a tabela1.tex ./../doc
		cd ../mat && cp -a tabela2.tex ./../doc
		cd ../mat && cp -a tabela3.tex ./../doc
		cd ../mat && cp -a tabela4.tex ./../doc
		cd ../mat && cp -a v6_natural.eps ./../doc
		cd ../mat && cp -a v6_forcada.eps ./../doc
		cd ../mat && cp -a v6.eps ./../doc
		cd ../mat && cp -a bode.eps ./../doc
		cd ../sim && cp -a trans.eps ./../doc
		cd ../sim && cp -a trans4.eps ./../doc
		cd ../sim && cp -a acm.eps ./../doc
		cd ../sim && cp -a acp.eps ./../doc

clean:
	@rm -rf *.aux *.bbl *.blg *.glg *.glo *.gls *.ilg *.ist *.lof *.ps tabela1.tex tabela4.tex
	@rm -rf *.log *.lot *.nlo *.nls *.out *.toc *~ *.*% ./*.pdf ./*.eps tabela2.tex tabela3.tex

.PHONY: all clean
