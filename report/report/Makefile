
nazwa = main
documents =
figures = 

documents_tex = $(addsuffix .tex,$(documents)) $(addsuffix .tex,$(nazwa))
figures_eps = $(addsuffix .eps,$(basename $(figures)))
figures_pdf = $(addsuffix .pdf,$(basename $(figures)))

.PHONY: all dvi ps pdf clean

all: dvi ps pdf
dvi: $(nazwa).dvi
ps: $(nazwa).ps
pdf: $(nazwa).pdf

%.eps:%.gif
	convert $< $@
%.pdf:%.gif
	convert $< $@
%.eps:%.jpg
	convert $< $@
%.pdf:%.jpg
	convert $< $@
%.eps:%.png
	convert $< $@
%.pdf:%.png
	convert $< $@
%.eps:%.jpeg
	convert $< $@
%.pdf:%.jpeg
	convert $< $@

$(nazwa).dvi: $(documents_tex) $(figures_eps) 
	latex $(nazwa).tex
	latex $(nazwa).tex

$(nazwa).ps: $(nazwa).dvi $(figures_eps) 
	dvips $(nazwa).dvi

$(nazwa).pdf: $(documents_tex) $(figures_pdf)
	pdflatex $(nazwa).tex
	pdflatex $(nazwa).tex


clean:
	rm -f $(nazwa).dvi
	rm -f $(nazwa).aux
	rm -f $(nazwa).log
	rm -f $(nazwa).ps
	rm -f $(nazwa).pdf
	rm -f $(nazwa).out
	rm -f $(nazwa).snm
	rm -f $(nazwa).toc
	rm -f $(nazwa).nav
