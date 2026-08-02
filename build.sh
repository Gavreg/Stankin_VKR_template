#!/bin/bash
set -e
set -o pipefail

export NPROC=$(( ( $(nproc || echo 4) ) * 2 ))
#export NPROC=1


export workdir="$PWD"


compile_tex() {

    set -o pipefail
    set -e

    f="$@"


    texfile=$(basename "$f")
    texfiledir=$(dirname "$f")
    texfilename=$(basename "$texfile" .tex) 

    cd "$texfiledir"
    
    if docker run --rm -v "$workdir":/data vkrlateximage \
        latexmk   -pdfxe \
            -interaction=nonstopmode  \
            -recorder- \
            -aux-directory="$texfiledir" \
            --output-directory="$texfiledir" \
            -halt-on-error  \
            -8bit \
            --shell-escape \
            -synctex=0  "$f" > /dev/null 2>&1 
    then 
        #rm -f "$texfilename".log > /dev/null 2>&1 || true 
        true
    else
        #mv  "$texfilename".log "$vkrlateximage".log.tmp  > /dev/null 2>&1  || true
        #docker run --rm -v "$workdir":/data vkrlateximage latexmk -C -cd "$f" > /dev/null 2>&1 
        #mv "$texfilename".log.tmp  "$texfilename".log  > /dev/null 2>&1   || true
        exit 255
    fi
}
export -f  compile_tex


parallel  -j "$NPROC" --halt-on-error soon,fail=1 --verbose 'compile_tex {}' ::: \
 ./main.tex  ./main_assigment.tex ./main_annotation.tex

