TEX = xelatex
BIB = biber
src = METP.tex
bcf = METP.bcf
PDF = METP.pdf

publish :
	$(TEX) $(src) && $(BIB) $(bcf) && $(TEX) $(src) && $(TEX) $(src) && rm *.aux *.log *.toc *.run.xml *.bbl *.blg *.bcf *.fdb_latexmk *.fls *.idx *.ilg *.ind && open $(PDF)

build :
	$(TEX) $(src) && $(BIB) $(bcf) && $(TEX) $(src) && $(TEX) $(src)

step :
	$(TEX) $(src)

.PHONY: clean
clean :
	rm *.aux *.log *.toc *.run.xml *.bbl *.blg *.bcf *.fdb_latexmk *.fls *.idx *.ilg *.ind *.lof *.lot *.pdf
