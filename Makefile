build: index.qmd about.qmd styles.css texDocs/cv.tex texDocs/researchStatement.tex
	if ! [ -d "texDocs/cv.pdf"]; then rm texDocs/cv.pdf; fi
	if ! [ -d "texDocs/researchStatement.pdf"]; then
	$(MAKE) texdocs
	quarto publish gh-pages --no-prompt

# %.pdf: texDocs/%.tex texDocs/myWorks.bib
# 	pdflatex -output-directory=texDocs texDocs/$*
# 	TEXMFOUTPUT="texDocs:" bibtex texDocs/$*  # Problematic because the cv file currently doens't need bibtex.
# 	pdflatex -output-directory=texDocs texDocs/$*
# 	pdflatex -output-directory=texDocs texDocs/$*
# 	rm -f texDocs/$*.aux texDocs/$*.log texDocs/$*.bbl texDocs/$*.blg texDocs/$*.out

texdocs:
	for f in $(TEXDOCS); do (make texDocs/$$f.pdf -B); done

# texDocs/%.pdf: texDocs/%.tex texDocs/myWorks.bib
# 	pdflatex -output-directory=texDocs texDocs/$*
# 	TEXMFOUTPUT="texDocs:" bibtex texDocs/$*
# 	pdflatex -output-directory=texDocs texDocs/$*
# 	pdflatex -output-directory=texDocs texDocs/$*
# 	rm -f texDocs/$*.aux texDocs/$*.log texDocs/$*.bbl texDocs/$*.blg texDocs/$*.out

texDocs/cv.pdf: texDocs/cv.tex
	pdflatex -output-directory=texDocs texDocs/cv
	rm -f texDocs/cv.aux texDocs/cv.log texDocs/cv.bbl texDocs/cv.blg texDocs/cv.out

texDocs/researchStatement.pdf: | texDocs/myWorks.bib texDocs/researchStatement.tex
	pdflatex -output-directory=texDocs texDocs/researchStatement
	TEXMFOUTPUT="texDocs:" bibtex texDocs/researchStatement
	pdflatex -output-directory=texDocs texDocs/researchStatement
	pdflatex -output-directory=texDocs texDocs/researchStatement
	rm -f texDocs/researchStatement.aux texDocs/researchStatement.log texDocs/researchStatement.bbl texDocs/researchStatement.blg texDocs/researchStatement.out
