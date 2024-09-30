---
title: "Make your workflowr project structure more flexible by trying out my code wrapper"
author: 'Isobel Beasley'
date: '2021-09-11'
slug: workflowr-flexibility-tool
categories: ['Resources', 'Research']
tags: ['R', 'workflowr']
subtitle: "Some R functions to make your workflowr life more fun (if you don't want to have all your rmarkdown files in the analysis subfolder)"
summary: "Some R functions to make your workflowr life more fun (if you don't want to have all your rmarkdown files in the analysis subfolder)"
authors: ['Isobel Beasley']
lastmod: '2023-11-05T04:23:36+11:00'
featured: yes
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects:
- 'pop_spec_eqtl'
---

The information below was originally written when I was a Masters student to help fellow lab members with less experience with R and git to start using workflowr to produce  reproducible documentation of their data analyses. But hopefully, it's also useful to broader audience: anyone who has a little bit of experience R coding, and is ready to expand their skills into R projects and git. 

... That being said, you likely want to avoid using these wrapper functions unless having all rmarkdown files in the analysis folder is really really going to bug you (and cause problems). For instance, I needed to make a workflowr page for every model I trained for my Masters' thesis, and I trained way to many models to be able to make any sense of a folder, without subfolders, containing all of them. The wrapper functions I used to do this (and describe below) can be found in [this RScript]( https://github.com/IJbeasley/Personal_Academic_Website/blob/main/content/code_sharing/workflowr_wrapper_functions.R)


Using workflowr wrapper functions (i.e **what do use if you don't want to have all your rmarkdown files in the analysis subfolder**)

workflowr doesn't allow you to have subfolders within the analysis folder, or to build or publish any rmarkdown documents within folders other than the analysis folder. To work around some of this problem I have adapted code from [here](https://github.com/jdblischak/workflowr/issues/95) and [here](https://github.com/jdblischak/workflowr/blob/master/R/wflow_publish.R) to create an
R-script of functions (workflowr_wrapper_functions.R) which wrap around the workflowr functions and let you build and publish files from folders other than analysis. These functions are:

1. ```wflow_dir_build``` (like wflow_build, but designed for building files outside of the analysis subfolder)
2. ```wflow_dir_publish``` (like wflow_publish, but designed for building files outside of the analysis subfolder)

These workaround functions are not perfect, and will cause workflowr to flag these pages as not completely reproducible. Hence, **you should always keep rmarkdown documents within the analysis subfolder where possible**, however if you need to publish a separate folder from analysis of rmarkdown documents, these functions are incredibly useful.

After downloading the workflowr_wrapper_functions R-script, you can access the functions in this script by:

1. Sourcing the R-script (simplest, but less reproducible and you cannot access the help information)
2. Using the R-package ```box``` (more reproducible, and you can access help information using it this way, so I would recommend this approach but if you haven’t used box before you should look at the steps shown below)


### Using the wrapper functions with ```box```:

This method requires installing ```box``` from CRAN using: ```install.packages(“box”)```. To read the function documentation you also need to install ```roxygen``` using``` install.packages("roxygen")```. For more information about the cool things box can do check out the [github repository](https://github.com/klmr/box), and the relevant [vignettes](https://klmr.me/box/articles/box.html).

Once you have installed box, you can then load the functions in this R-script almost as if they were function from an R package, using:

```
box::use(./workflowr_wrapper_functions) #use is the box equivalent of library`
```

If the R script of functions is in another directory (not the currently set directory), then you also need to tell box where to find the R script. For example, if it is found in the code subfolder of the currently set directory:

```
box::use(code/workflowr_wrapper_functions)
```

To actually use the building function (```wflow_dir_build```), you can then access it using:

```
workflowr_wrapper_functions$wflow_dir_build() # $ is the box equivalent of ::
```

### Getting help / more information on these wrapper functions

If you want to read the documentation for the functions, you will also need to install ```roxygen``` if you haven’t already. 

Then, you can for example, read the document for the building function (````wflow_dir_build```), using 
```
box::help(workflowr_wrapper_functions$wflow_dir_build) # basically the same as help() for typical R-packages 
```
