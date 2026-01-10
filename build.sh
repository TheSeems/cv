#!/bin/bash
set -e

cd src

compile_cv() {
    local lang=$1
    local output_dir="../output/$lang"
    
    echo "Compiling CV for language: $lang"
    
    local babellang="english"
    if [ "$lang" = "ru" ]; then
        babellang="russian"
    fi
    
    xelatex -interaction=nonstopmode -jobname=cv-llt "\def\cvlang{$lang}\def\babellang{$babellang}\input{cv-llt.tex}"
    biber cv-llt
    xelatex -interaction=nonstopmode -jobname=cv-llt "\def\cvlang{$lang}\def\babellang{$babellang}\input{cv-llt.tex}"
    xelatex -interaction=nonstopmode -jobname=cv-llt "\def\cvlang{$lang}\def\babellang{$babellang}\input{cv-llt.tex}"
    
    mkdir -p "$output_dir"
    mv cv-llt.pdf "$output_dir/cv.pdf"
    
    echo "CV compiled successfully: $output_dir/cv.pdf"
}

compile_cv en
compile_cv ru

rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml *.toc

echo "All CVs compiled successfully!"

