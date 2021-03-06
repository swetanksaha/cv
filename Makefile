LATEXC = pdflatex

TEX_FILE = cv_swetank-kumar-saha
MODERNCV_DIR = moderncv
MODERNCV_GITHUB = https://github.com/xdanaux/moderncv.git

all: $(TEX_FILE).pdf view

export TEXINPUTS:=.:./texmf:~/texmf:$(MODERNCV_DIR):${TEXINPUTS}

$(TEX_FILE).pdf: $(MODERNCV_DIR) $(TEX_FILE).tex
	echo ${TEXINPUTS}
	$(LATEXC) $(TEX_FILE)
	$(LATEXC) $(TEX_FILE)

$(MODERNCV_DIR):
	if [ ! -d $(MODERNCV_DIR) ]; then \
		git clone $(MODERNCV_GITHUB); \
	fi

UNAME_S := $(shell uname -s)
view: $(TEX_FILE).pdf
ifeq ($(UNAME_S),Darwin)
	open $(TEX_FILE).pdf &
else
	xdg-open $(TEX_FILE).pdf &
endif

clean:
	rm -rf $(TEX_FILE).aux $(TEX_FILE).log $(TEX_FILE).out $(TEX_FILE).pdf

cleanmoderncv:
	rm -rf $(MODERNCV_DIR)
