#!/bin/bash

### Updating ===============================
echo updating index.html
cd /home/yfhuang/Documents
R -e "rmarkdown::render('McCrometer_Visualization.Rmd',output_file='index.html')"


### Uploading via git ======================
echo uploading the website

cd /home/yfhuang/Documents/github/TsangStreamLab.github.io
cp ../../index.html .
git add index.html
git commit -m "uploaded index.html"
git push


