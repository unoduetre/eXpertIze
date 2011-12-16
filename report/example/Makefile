
nazwa = main
documents =
figures  = 1.xwd 2.xwd 3.xwd 4.xwd 5.xwd 6.xwd 7.xwd 8.xwd 9.xwd 10.xwd
figures += 11.xwd 12.xwd 13.xwd 14.xwd
figures += 15.xwd 16.xwd 17.xwd 18.xwd
figures += 19.xwd 20.xwd 21.xwd 22.xwd 23.xwd 24.xwd

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
%.eps:%.xwd
	convert $< $@
%.pdf:%.xwd
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
