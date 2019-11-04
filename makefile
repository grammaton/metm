TEX = xelatex
BIB = biber
src = METM.tex
bcf = METM.bcf
PDF = METM.pdf

buildclean :
	$(TEX) $(src) && $(BIB) $(bcf) && $(TEX) $(src) && rm *.aux *.log *.toc *.run.xml *.bbl *.blg *.bcf *.fdb_latexmk *.fls *.idx *.ilg *.ind && open $(PDF)

build :
	$(TEX) $(src) && $(BIB) $(bcf) && $(TEX) $(src) 

rebuild :
	$(TEX) $(src)

.PHONY: clean
clean :
	rm *.aux *.log *.toc *.run.xml *.bbl *.blg *.bcf *.fdb_latexmk *.fls *.idx *.ilg *.ind
