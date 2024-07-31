---
date: "2021-07-20T00:00:00Z"
external_link: ""
lastmod:  "2024-01-27T00:00:00Z"
categories: ['Research', 'Graduate', 'Masters', 'Thesis']

image: 
  placement: 1
  alt_text: "Created with [BioRender.com](https:://BioRender.com/)"
  caption: "Created with [BioRender.com](https://BioRender.com/)"
  focal_point: Center
  preview_only: true
links:
- icon: gitlab
  icon_pack: fab
  name: "gitlab repository"
  url: https://gitlab.unimelb.edu.au/igr-lab/pop_spec_eqtl_ml
- icon: globe
  icon_pack: fas
  name: "workflowr page"
  url: https://igr-lab.pages.gitlab.unimelb.edu.au/pop_spec_eqtl_ml/thesis_index.html
- icon: file-pdf
  icon_pack: far
  name: "Msc Thesis PDF"
  url: "https://drive.google.com/file/d/1d_IAEnFdu-_zpn0F_i-AHm1zN8N9Vmtt/view?usp=sharing"
# - icon: biorxiv
#   icon_pack: aiBiocManager::install("rhdf5filters")
#   name: Preprint
#   url: https://www.biorxiv.org/
slides: 
summary: "Masters research project investigating the evolutionary, functional and expression properties of human eQTLs which are non-portable across populations, supervised by: [Dr. Irene Gallego Romero](https://igr-lab.science.unimelb.edu.au/) & [Dr. Christina Azodi](https://azodichr.github.io/) (March 2021 - December 2022)"
tags:
- "Machine Learning"
- R
- Python
- eQTLs
- Genomics
- Population Genetics
- Diversity
- Precision medicine
- Genomic medicine
- Polygenic risk scores
- Portability
- Equity
- Human
- Melbourne University
- "St Vincent's Institute of Medical Research"
title: "Predicting the cross population portability of human eQTLs"
subtitle: "Master of Science Thesis Project supervised by: [Dr. Irene Gallego Romero](https://www.svi.edu.au/laboratories/human-genomics-and-evolution/) & [Dr. Christina Azodi](https://azodichr.github.io/)"
url_code: ""
url_pdf: ""
url_confererence: ""
url_slides: ""
url_video: ""
# toc: true
# output:
#   html_document:
#     theme:
#       version: 4
---

### Motivation 

Personalised medicine, the targeting of treatment decisions to a patient's genetic makeup, is the future of medical practice. Using this approach, doctors can select the best medicine for their patients without the trial and error that causes dangerous delays to treatment today. 

The most glaring obstacle to the more widespread use of personalised medicine is our research subjects: genetics research participants are typically individuals of European ancestry (see [1](https://www.nature.com/articles/538161a),[2](https://www.healthaffairs.org/doi/10.1377/hlthaff.2017.1595),[3](https://www.nature.com/articles/s41591-021-01672-4)). At first, this may seem like a minor problem since the same biological pathways connect genes with disease for every human being. However, we find different associations between genetics and disease when we repeat studies across ancestries or socio-economic statuses (e.g. [4](https://www.nature.com/articles/s41588-019-0379-x),[5](https://elifesciences.org/articles/48376),[6](https://www.nature.com/articles/s41586-023-06079-4),[7](https://www.medrxiv.org/content/10.1101/2023.05.10.23289777.abstract)). Thus, the mathematical models we use to predict the individual genetic risk of developing disease are often much less accurate for anyone who falls outside of the narrowly defined 'European' ancestry: a phenomenon known as the 'non-portability' problem. If we rolled out personalised medicine today, the 'non-portability' problem would lead us to further entrench current health inequalities. 

<br> 

### Aims and methods  

One way to improve the equitability of these precision medicine models is to better understand which genetic associations are likely to differ across human groups and why they differ. Towards this overarching goal, I developed machine learning models that predict whether or not one type of genetic association (expression quantitative trait loci, eQTL) is likely to be different across human groups.


<img src="/media/project/thesis_methods_figure.png" width="689.25px" height="900px" alt="Figure of the method steps taken">
<b> Method Workflow Steps </b> 
<br> 
<b> (A): </b>  Integrate summary statistics from published eQTL studies. </b> <br>
<b> (B): </b> Classify gene-SNP (single-nucleotide polymorphisms) pairs as being eQTLs or not, and then, eQTLs as being portable across populations, or not. </b> <br>
<b> (C): </b> Use publicly available datasets to obtain, and engineer the genomic features of eQTLs. </b> <br>
<b> (D): </b> Use ~10% of these eQTLs to train machine learning models. </b> <br>
<b> (E): </b> Test models performance, use the best model to investigate features which differentiate portable and non-portable eQTLs. </b> 
</img> 

<br>
I first tested a variety of approaches to developing these models to uncover what approach would produce the highest-performing models. Then, I used this preferred approach to create models and investigate what information they used to successfully identify which genetic associations are different across human populations.

<br>

### Conclusions 

I demonstrated that applying a multi-adaptive shrinkage method (mashr) to these summary statistics improved power, and increased eQTL and eGene sharing across populations. I found that of all machine learning algorithms tested, decision-tree based classifiers (Random Forest, Gradient Boosting) were best able to recapitulate portable and non-portable eQTLs classes on an independent held-out test set. Then, after uncovering the optimal machine learning training set up, I trained a model for every possible pairwise population portability comparison (median improvement over random chance auPRC= 0.073 across eight models in two cell types). Applying Leave-One-Feature-Out feature importance procedures to these models found no feature category, or set of features, had a significant or consistent greatest impact on model performance. Finally, by comparing my datasets with the set of 6 GTEx identified population-biased whole-blood eQTLs, I uncovered a plausible example of an eQTL portable in a tissue-dependent manner (rs2299818_ENSG00000160221).

<br> 
