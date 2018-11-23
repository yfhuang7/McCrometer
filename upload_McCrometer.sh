#!/bin/bash

### Updating ===============================
echo updating index.html
cd /home/yfhuang/Documents   # The directory where you put your scripts

Rscript McCrometer_Download.R   # Run the R script for downloading data

# Run the Rmarkdown for excute the .html that you want to put on your website
R -e "rmarkdown::render('McCrometer_Visualization.Rmd',output_file='index.html')"   


### Uploading via git ======================
echo uploading the website

cd /home/yfhuang/Documents/github/TsangStreamLab.github.io  # the directory for your gitpage directory
cp ../../index.html .  # copy the .html file to your git directory
git add index.html
git commit -m "uploaded index.html"
git push


