#!/bin/bash
set -e

cd src

# Compile with XeLaTeX
xelatex -interaction=nonstopmode cv-llt.tex

# Run Biber for bibliography
biber cv-llt

# Compile again to include bibliography
xelatex -interaction=nonstopmode cv-llt.tex

# Final compilation to resolve all references
xelatex -interaction=nonstopmode cv-llt.tex

# Move PDF to output directory
mkdir -p ../output
mv cv-llt.pdf ../output/cv.pdf

echo "CV compiled successfully: output/cv.pdf"

