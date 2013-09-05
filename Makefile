# Andrew Borgman
# VARI BBC 
# 8/28/2013
# Builds report for project

# This uses pdflatex to compile a TeX document [output from LyX] to PDF
presentation/git_bbc_rip.pdf:presentation/git_bbc_rip.tex report/crc-tumor-analysis.pdf
	cd presentation; pdflatex git_bbc_rip.tex; cd..

# This uses pdflatex to compile a TeX document [output from LyX] to PDF
report/crc-tumor-analysis.pdf:report/crc-tumor-analysis.tex report/tables/JPM16.tex
	cd report; pdflatex crc-tumor-analysis.tex; cd..

# This runs the XenoCat script that outputs a bunch of files and tables for a report.
report/tables/JPM16.tex:src/xeno-catter.R
	mkdir report/tables/; mkdir report/images/; Rscript --vanilla src/xeno-catter.R

# Clear out all the report stuff the right way
clean:
	rm presentation/*.pdf
	rm report/tables/*.tex
	rm report/images/*.pdf
	rm report/*.pdf
