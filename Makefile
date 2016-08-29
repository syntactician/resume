.POSIX:
LMAKE := latexmk -pdfps -silent
VI := vi -u NONE -es

.SUFFIXES: .tex .pdf
.tex.pdf:
	$(LMAKE) $*
	$(MAKE) sweep

.PHONY: all
all: resume cv

.PHONY: clean
clean: sweep
	$(LMAKE) -C
	rm -f cv.pdf

.PHONY: sweep
sweep:
	$(LMAKE) -c
	rm -f *.dvi *.ps

.INTERMEDIATE: cv.tex
cv.tex: resume.tex
	$(VI) -c '%s/^.*%CV.\=//g' -c 'w cv.tex' -c 'q!' resume.tex

.PHONY: cv resume
cv: cv.pdf
resume: resume.pdf
