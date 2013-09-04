# Andrew Borgman
# VARI BBC 
# 8/28/2013
# Builds report for project

# This uses pdflatex to compile a TeX document [output from LyX] to PDF
report/crc-tumor-analysis.pdf:report/crc-tumor-analysis.tex report/tables/JPM16.tex
	cd report; pdflatex crc-tumor-analysis.tex

# This runs the XenoCat script that outputs a bunch of files and tables for a report.
report/tables/JPM16.tex:src/xeno-catter.R
	Rscript --vanilla src/xeno-catter.R

# This works
clean:
	rm report/tables/JPM16.tex
	rm report/crc-tumor-analysis.pdf