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
#	cp -f ../sim/*.eps .
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex


#convert libreoffice draw figures to pdf
%.pdf: %.odg
	soffice --headless --convert-to pdf $<

data:
			cd ../mat && cp -a tabela1.tex ./../doc
			cd ../mat && cp -a tabela2.tex ./../doc
			cd ../mat && cp -a gain.eps ./../doc
			cd ../sim && cp -a vin.eps ./../doc
			cd ../sim && cp -a vo1.eps ./../doc
			cd ../sim && cp -a vo2.eps ./../doc
			cd ../sim && cp -a vo1f.eps ./../doc
			cd ../sim && cp -a vo2f.eps ./../doc



clean:
	@rm -rf *.aux *.bbl *.blg *.glg *.glo *.gls *.ilg *.ist *.lof tabela1.tex
	@rm -rf *.log *.lot *.nlo *.nls *.out *.toc *~ *.*% ./*.pdf ./*.eps tabela2.tex

.PHONY: all clean
