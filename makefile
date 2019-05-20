TEX = xelatex
BIB = biber
src = METM.tex
bcf = METM.bcf
PDF = METM.pdf

build :
	$(TEX) $(src) && $(BIB) $(bcf) && $(TEX) $(src) && rm *.aux *.log *.toc *.run.xml *.bbl *.blg *.bcf &&	open $(PDF)

rebuild :
	$(TEX) $(src)

.PHONY: clean
clean :
	rm *.pdf *.aux *.log *.toc
