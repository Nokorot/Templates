#!/bin/bash

pdfName=${PWD##*/}
texfile=main.tex
log_dir=".log"


build() {
    job_name="$(echo "$texfile" | sed 's,\.[^.]*,,')"

	mkdir -p "$log_dir"
    ##  LiveTeX
	# pdflatex --output-dir=$log_dir --job-name="$job_name" "$texfile"  
    ## MiKTeX
	pdflatex --output-directory="$log_dir" --job-name="$job_name" "$texfile" 
	mv "$log_dir/$job_name.pdf" "$pdfName.pdf"
}

watch() { watchexec -e md make build; }
clean() { rm "$log_dir" auto "*log$" "*\.synctex\.gz$" "*\.aux$"; }

## add argument 
# --name <pdfName>

usage() {
    printf "Usage: $0 [-n <pdfName>] [-f <texfile>] <option> \n\t options:\n"
    printf "\t\t open:  \topens the pdf file with 'gio open'.\n"
    printf "\t\t silent:\tcompiles with minimal output.\n"
    printf "\t\t clean: \tremoves compile files.\n"
    printf "\t\t watch: \trecomplies when file is changed.\n"
    printf "\t\t *:     \tcomplies the pdf\n"
}

SILENT=false
while getopts "hn:f:" o; do case "${o}" in
    n) pdfName=$OPTARG ;;
    f) texfile=$OPTARG ;;
    s) SILENT=true     ;; 
    *) usage && exit ;;
esac done

case $1 in
	pnt)    echo $pdfName ;;
	open)   gio open $pdfName.pdf ;;
	clean)  clean ;;
	watch)  watch ;; 
	*)      $SILENT && build > /dev/null \
                build;;
esac

