# directories
DATA = data
FIGURES = figures

# targets
all: final_report.pdf
  
# creating clean data csv
data/covid_clean.csv: data_cleaning.R biosproject.csv
		mkdir -p $(DATA)
	Rscript data_cleaning.R

# creating table 1
figures/table1.png: table_one.R $(DATA)/covid_clean.csv 
		mkdir -p $(DATA)
	Rscript table_one.R

# creating visualizations
figures/age_distribution.png \
figures/worry.png \
figures/depression.png \
figures/heatmap.png \
figures/impact.png \
figures/vaccine.png: visualizations.R $(DATA)/covid_clean.csv
		mkdir -p $(DATA)
	Rscript visualizations.R
	
	
# make final report
final_report.pdf: final_report.Rmd figures/table1.png figures/age_distribution.png figures/worry.png figures/depression.png figures/heatmap.png figures/impact.png figures/vaccine.png
	R -e "rmarkdown::render('final_report.Rmd', output_format = 'pdf_document')"


# make clean
clean:
	rm -rf $(DATA)/* $(FIGURES)/*

.PHONY: all clean