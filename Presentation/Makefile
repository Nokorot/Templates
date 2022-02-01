build:
	mkdir -p .log/ 
	pdflatex --interaction=nonstopmode --output-dir=.log main.tex > /dev/null 
	mv .log/main.pdf main.pdf
watch:
	watchexec -e md make build

all: build
