
SLIDES := $(patsubst %.Rmd,%.slides.pdf,$(wildcard source/Lecture-*.Rmd))
IOSLIDES := $(patsubst %.Rmd,%.ioslides.html,$(wildcard source/Lecture-*.Rmd))
REVEALJS := $(patsubst %.Rmd,%.revealjs.html,$(wildcard source/Lecture-*.Rmd))
SLIDY := $(patsubst %.Rmd,%.slidy.html,$(wildcard source/Lecture-*.Rmd))
HANDOUT := $(patsubst %.Rmd,%.handout.pdf,$(wildcard source/Lecture-*.Rmd))
TUFTE := $(patsubst %.Rmd,%.tufte.pdf,$(wildcard source/Lecture-*.Rmd))
PRACTICAL := $(patsubst %.Rmd,%.practical.pdf,$(wildcard source/Practical-*.Rmd))
ASSIGNMENT := $(patsubst %.Rmd,%.assignment.pdf,$(wildcard source/Assignment-*.Rmd))
MARKDOWN := $(patsubst %.Rmd,%.markdown.md,$(wildcard source/*.Rmd))
DOCS := $(patsubst %.Rmd,%.docs.docx,$(wildcard Lecture-*.Rmd))
PRACTDOCS := $(patsubst %.Rmd,%.practicals.docx,$(wildcard Practical-*.Rmd))
PPTSLIDES := $(patsubst %.pdf,%.pptslides.pdf,$(wildcard published/pdf/slides/Lecture-*.pdf))

all: ioslides revealjs slidy slides handouts tufte practicals assignments ppts

#all: slides


slides : $(SLIDES)

ioslides : $(IOSLIDES)


revealjs : $(REVEALJS)

slidy : $(SLIDY)

handouts: $(HANDOUT)

tufte: $(TUFTE)


practicals: $(PRACTICAL)

assignments: $(ASSIGNMENT)

markdown: $(MARKDOWN)

docs : $(DOCS)

pracs : $(PRACTDOCS)

ppts: $(PPTSLIDES)

%.pptslides.pdf : %.pdf
  @echo "Processing PPTs: $<"

%.slides.pdf : %.Rmd
	@echo "Processing Slides: $<"
	@if [[ $< -nt ./published/pdf/slides/$(notdir $(basename  $<))-SLIDES.pdf ]]; then  Rscript -e "rmarkdown::render('$<','beamer_presentation', output_file ='../published/pdf/slides/$(notdir $(basename  $<))-SLIDES.pdf')" ; else echo "File has not changed"; fi


%.ioslides.html : %.Rmd
	@echo "Processing ioslides: $< -> $@"
	@if [[ $< -nt ../published/ioslides/$(notdir $(basename  $<)).html ]]; then Rscript -e "rmarkdown::render('$<','ioslides_presentation')"; mv source/$(notdir $(basename  $<)).html ./published/ioslides/  ; else echo "File has not changed"; fi

%.revealjs.html : %.Rmd
	@echo "Processing ioslides: $< -> $@"
	@if [[ $< -nt ./published/revealjs/$(notdir $(basename  $<)).html ]]; then Rscript -e "rmarkdown::render('$<','revealjs::revealjs_presentation')"; mv source/$(notdir $(basename  $<)).html ./published/revealjs/  ; else echo "File has not changed"; fi



%.slidy.html : %.Rmd
	@echo "Processing slidy: $<"
	@if [[ $< -nt ./published/slidy/$(notdir $(basename  $<)).html ]]; then Rscript -e "rmarkdown::render('$<','slidy_presentation')"; mv source/$(notdir $(basename  $<)).html ./published/slidy/ ; else echo "File has not changed"; fi


%.handout.pdf : %.Rmd
	@echo "Processing handouts: $<"

		@if [[ $< -nt ./published/pdf/handouts/$(notdir $(basename  $<))-HANDOUT.pdf ]]; then  Rscript -e "rmarkdown::render('$<','pdf_document', output_file ='../published/pdf/handouts/$(notdir $(basename  $<))-HANDOUT.pdf')" ; else echo "File has not changed"; fi

%.tufte.pdf : %.Rmd
	@echo "Processing Tufte handouts: $<"

		@if [[ $< -nt ./published/pdf/tufte/$(notdir $(basename  $<))-TUFTE.pdf ]]; then  Rscript -e "rmarkdown::render('$<','rmarkdown::tufte_handout', output_file ='../published/pdf/tufte/$(notdir $(basename  $<))-TUFTE.pdf')" ; else echo "File has not changed"; fi


%.practical.pdf : %.Rmd
	@echo "Processing practicals: $<"
	@if [[ $< -nt ./published/pdf/practicals/$(notdir $(basename  $<)).pdf ]]; then  Rscript -e "rmarkdown::render('$<','pdf_document', output_file ='../published/pdf/practicals/$(notdir $(basename  $<)).pdf')" ; else echo "File  has not changed"; fi

%.assignment.pdf : %.Rmd
	@echo "Processing assignments: $<"
	@if [[ $< -nt ./published/pdf/assignments/$(notdir $(basename  $<)).pdf ]]; then  Rscript -e "rmarkdown::render('$<','pdf_document', output_file ='../published/pdf/assignments/$(notdir $(basename  $<)).pdf')" ; else echo "File  has not changed"; fi

%.markdown.md : %.Rmd
	@echo "Processing markdown: $<"
	@if [[ $< -nt ./published/epub/$(notdir $(basename  $<)).mobi ]]; then  Rscript -e "rmarkdown::render('$<','md_document', output_file ='../published/md/$(notdir $(basename  $<)).md')" ; pandoc --toc --epub-stylesheet=../includes/epub/stylesheet.css ./published/md/$(basename $<).md -o ./published/epub/$(basename $<).epub ; /Applications/calibre.app/Contents/MacOS/ebook-convert ./published/epub/$(basename $<).epub ./published/epub/$(basename $<).mobi ; else echo "File  has not changed"; fi

%.docs.docx : %.Rmd
	@echo "Processing word docs: $<"
	@if [[ $< -nt ./published/docs/$(notdir $(basename  $<)).docx ]]; then  Rscript -e "rmarkdown::render('$<','word_document', output_file ='../published/docs/$(notdir $(basename  $<)).docx')" ; else echo "File  has not changed"; fi

%.practicals.docx  : %.Rmd
	@echo "Processing Practical word docs: $<"
	@if [[ $< -nt ./published/docs/$(notdir $(basename  $<)).docx ]]; then  Rscript -e "rmarkdown::render('$<','word_document', output_file ='../published/docs/$(notdir $(basename  $<)).docx')" ; else echo "File  has not changed"; fi


clean:
	rm ./published/*.pdf
