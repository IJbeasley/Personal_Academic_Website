---
date: "2021-02-27T00:00:00Z"
external_link: ""
image:
  caption: "Created with [BioRender](https://BioRender.com)"
  focal_point: Smart
  preview_only: true
links:
#- icon: google-scholar
#  icon_pack: ai
#  name: 
#  link: https://scholar.google.co.uk/citations?user=sIwtMXoAAAAJ
- icon: file-pdf
  icon_pack: fas
  name: ESEB 2019 Conference Poster
  url: "media/ESEB_2019_poster_Filip_Ruzicka_Monash_University.pdf" 
slides: 
summary: "A short winter vacation project investigating the association between inversions and sexually antagonistic genes, supervised by: [Dr. Filip Ruzicka](https://orcid.org/0000-0001-9089-624X) and [Dr. Tim Connallon](https://connallonresearch.wordpress.com/) (June 2019)  "
categories: ['Research', 'Undergraduate', '2019', 'Monash']
tags:
- Evolutionary Theory
- Polymorphism
- Inversions
- Sexual Antagonism
- Drosophila
- Monash University
- R
- Data Science
title: "Testing a theory for the evolution of inversions"
subtitle: "Supervised by: [Dr. Filip Ruzicka](https://research.monash.edu/en/persons/filip-ruzicka) and [Dr. Tim Connallon](https://connallonresearch.wordpress.com/)"
url_code: ""
url_pdf: 
#url_slides: " "
url_video: 
---

Whether a genetic variant has a beneficial, neutral, or negative impact on individual fitness can differ between the sexes. Evolutionary theory (e.g. Kirkpatrick and Barton 2006) proposes that variants with opposite fitness effects in each sex (sexually antagonistic variants) are likely to accumulate on one type of mutation, inversion polymorphisms. 

Under the supervision of Dr. Filip Ruzicka and Dr. Tim Connallon, I aimed to test this theoretical prediction, specifically: are sexually antagonistic variants in * D. melanogaster * more commonly found within inversion polymorphisms than would be expected by chance? From the initial starting point of a table of polymorphisms in the book Drosophila Inversion Polymorphisms (Lemeunier and Aulard 1992), I used Google Scholar to develop a csv data file of inversion locations. The genomic location of inversions were typically provided in cytogenetic map position values, so I wrote R scripts converting their stated location into R6 reference genome coordinates using FlyBase data. Finally, I performed Chi-squared and permutation tests of their overlap with a published set of sexually antagonistic variants discovered in genome-wide association studies. 

Contrary to predictions, I observed no difference between sexually antagonistic variants, and variants associated with an orthogonal phenotype, in terms of how frequently they overlapped common or rare inversions. However, as my analysis likely did not completely control for the effect of linkage disequilibrium, the theoretical models I was testing may yet still be providing accurate predictions.


