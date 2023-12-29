---
date: "2021-07-20T00:00:00Z"
external_link: ""
image:
  caption: "Created with [BioRender.com](BioRender.com)"
  focal_point: Smart
links:
- icon: gitlab
  icon_pack: fab
  name: "gitlab repository"
  url: https://gitlab.unimelb.edu.au/igr-lab/pop_spec_eqtl_ml
- icon: globe
  icon_pack: fas
  name: "workflowr page"
  url: https://igr-lab.pages.gitlab.unimelb.edu.au/pop_spec_eqtl_ml/index.html
# - icon: biorxiv
#   icon_pack: aiBiocManager::install("rhdf5filters")
#   name: Preprint
#   url: https://www.biorxiv.org/
# - icon: osf
#   icon_pack: ai
#   name: OCURA 2020 Conference Abstract & Poster
#   url: https://osf.io/rhnsz/
# - icon: file-pdf
#   icon_pack: fas
#   name: UROP 2020 Conference Slides
#   url: "media/UROP-Conference-2020.pdf"
# - icon: video
#   icon_pack: fas
#   name: UROP 2020 Conference Presentation 
#   url: "media/UROP_Conference_Beasley_Final.mp4"
slides: 
summary: "Masters research project investigating the evolutionary, functional and expression properties of human eQTLs which are non-portable across populations, supervised by: [Dr. Irene Gallego Romero](https://igr-lab.science.unimelb.edu.au/) & [Dr. Christina Azodi](https://azodichr.github.io/) (March 2021 - December 2022)"
tags:
- Machine Learning
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
- St Vincent's Institute of Medical Research
title: "Predicting the cross population portability of human eQTLs"
subtitle: "Supervised by: [Dr. Irene Gallego Romero](https://igr-lab.science.unimelb.edu.au/) & [Dr. Christina Azodi](https://azodichr.github.io/)"
url_code: 
url_pdf: 
url_confererence: 
url_slides: ""
url_video: ""
---

Somewhat less technical summary of my master's thesis:

Personalised medicine, the targeting of treatment decisions to a patient's genetic makeup, is the future of medical practice. Using this approach, doctors can select the best medicine for their patients without the trial and error that causes dangerous delays to treatment today. 

The most glaring obstacle to the more widespread use of personalised medicine is our research subjects: genetics research participants are typically individuals of European ancestry (see [1](https://www.nature.com/articles/538161a),[2](https://www.healthaffairs.org/doi/10.1377/hlthaff.2017.1595), [3](https://www.nature.com/articles/s41591-021-01672-4)). At first, this may seem like a minor problem since the same biological pathways connect genes with disease for every human being. However, we find different associations between genetics and disease when we repeat studies across ancestries or socio-economic statuses (e.g. [4](https://www.nature.com/articles/s41588-019-0379-x), [5](https://elifesciences.org/articles/48376), [6](https://www.nature.com/articles/s41586-023-06079-4),[7](https://www.medrxiv.org/content/10.1101/2023.05.10.23289777.abstract)). Thus, the mathematical models we use to predict the individual genetic risk of developing disease are often much less accurate for anyone who falls outside of the narrowly defined 'European' ancestry: a phenomenon known as the 'non-portability' problem. If we rolled out personalised medicine today, the 'non-portability' problem would lead us to further entrench current health inequalities. 

One way to improve the equitability of these precision medicine models is to better understand which genetic associations are likely to differ across human groups and why they differ. Towards this overarching goal, in my master's project, I developed machine learning models that predict whether or not one type of genetic association (expression quantitative trait loci, eQTL) is likely to be different across human groups. I first tested a variety of approaches to developing these models to uncover what approach would produce the highest-performing models. Then, I used this preferred approach to create models and investigate what information they used to successfully identify which genetic associations are different across human populations.   