# ---------------------------------------------------------
# type the "make" command to create report.pdf
# ---------------------------------------------------------

#doc name
FILE=report

#list of LibreOffice Draw files
LODFIGS = $(patsubst %.odg,%.pdf,$(wildcard *.odg))

all:  $(FILE).pdf
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
		cd ../mat && cp -a venvlope.eps ./../doc
		cd ../mat && cp -a vripple.eps ./../doc
		cd ../sim && cp -a transout.eps ./../doc
		cd ../sim && cp -a transripple.eps ./../doc




clean:
	@rm -rf *.aux *.bbl *.blg *.glg *.glo *.gls *.ilg *.ist *.lof
	@rm -rf *.log *.lot *.nlo *.nls *.out *.toc *~ *.*% ./*.pdf ./*.eps .~*

.PHONY: all clean
