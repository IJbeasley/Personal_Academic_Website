---
title: Using workflowr and gitlab with R projects
author: ''
date: '2021-09-11'
slug: workflowr-intro
categories: []
tags: []
subtitle: ''
summary: 'An introduction to using workflowr with a university or institutional gitlab account'
authors: []
lastmod: '2023-11-05T04:23:36+11:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---


The information below was originally written when I was a Masters student to help lab members with less experience with R and git to start using workflowr to produce  reproducible documentation of their data analyses. But hopefully, its also useful to broader audience: anyone who has a little bit of experience R coding, and is ready to expand their skills into R projects and git. 

## What is workflowr?

```workflowr``` is an R package for documenting analyses of data in a way that is shareable, reproducible, organised and trackable. Specifically, it builds a webpage that you can share with others, from a set of rmarkdown documents. An example webpage, showing how I've used workflowr for bioinformatic analyses can be found  [here](https://igr-lab.pages.gitlab.unimelb.edu.au/pop_spec_eqtl_ml/index.html).

### Useful introductory resources

For a good introduction to the ````workflowr``` package, you can watch the following [video](https://www.youtube.com/watch?v=GrqM2VqIQ20&ab_channel=RConsortium). Additionally, you should check out the [workflowr github page](https://jdblischak.github.io/workflowr/index.html) and in particular the workflowr [getting started vingette](https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html). If you are unfamiliar with rmarkdown there's plenty of information available online, including documentation [here](https://bookdown.org/yihui/rmarkdown/) and a useful, brief, introductory video [here](https://www.youtube.com/watch?v=DNS7i2m4sB0&ab_channel=RogerPeng). 

<p> </p> 

----

<p> </p>

## Brief Git Introduction

Git is used behind the scenes in workflowr, and it's reasonably likely you'll end up using git at some point in bioinformatics research, so getting familiar with the ideas behind git and some of the git 'lingo' is also valuable. I personally found [this lecture](https://missing.csail.mit.edu/2020/version-control/) from [MIT's The Missing Semester of Your CS Education](https://missing.csail.mit.edu/) course useful. 

In brief, git is a widely used version control software. Git is used to track changes that occur to a group of files over time. Each change (or group of changes) you want to track is 'committed' (think 'commitment'), alongside information about who decided to track this change, when they decided this. Additional, every time time you 'commit' to a change you should write a short message explaining what this change was and why this change was made. A group of files which are tracked together are called a repository (or project if using gitlab). In most cases this is just the 'big' folder which contains all the files and folders you want to track together. 

There are always multiple copies of git projects / repositories. At a minimum, there is the copy you have on your computer or on HPC cluster (called the local version), and the copy on gitlab (or github). Any time you commit to changes on your local copy, you can upload these changes to the copy on gitlab by pushing them. 

### .gitignore files

Since there are particular types of files you really do not want git to track (for example data - believe me you really do not want git to track data), you can prevent yourself from accidentally committing (tracking) these files by having a .gitignore file in your repository (example .gitignore file [here](https://gitlab.unimelb.edu.au/igr-lab/pop_spec_eqtl_ml/-/blob/master/.gitignore)).

A .gitignore file is essentially a list of the types of files or folders you would like git to ignore. One you have added these files types to your .gitignore file (and committed this change to your .gitignore file!), it is then quite hard for you to track these files types accidentally. For example, if your .gitignore file contains ```*.csv```, this tells git to ignore all csv files in your repository. If you'd like your git to ignore a folder called data, you can use ```**/data```. For different ways of telling git to ignore things see this [webpage](https://www.atlassian.com/git/tutorials/saving-changes/gitignore). 

Furthermore, from [this example file](https://gitlab.unimelb.edu.au/igr-lab/pop_spec_eqtl_ml/-/blob/master/.gitignore) you'll notice that I avoid tracking changes to cached files (py_cache), and slurm .out files. This is because you should only track files which are relatively small (<100 mb, but generally each file should be much smaller than this), and generally files you'd be very sad to lose. Cache files are fairly forgettable, and .out files do not change over time, so I'm not interested in tracking these files. 

<p> </p> 

---

<p> </p>


## **Getting started with workflowr**

Exactly how you start using workflowr will depend on what stage the project you are working on is at. In general you will need to configure git (if you haven't already) and then initialise the workflowr project. **Importantly, to get your workflowr page to be uploaded and published on an institutional gitlab group page (e.g. The University of Melbourne's gitlab, gitlab.unimelb.edu.au) you need to perform an extra step (3), which is not listed in the general advice about starting workflowr projects.**

### (0) Create a repository ('project')

If you haven't already created a repository, I would recommend making a new folder, calling it an informative name and then navigating to this folder. This new folder should be the 'big' folder which will eventually contain all the files and folders you'd like to track together. 

### (1) Configuring git 

If you haven't already, you should sign up for a gitlab or github account you want to use for the project. You should then configure (tell) git your gitlab user name and email address so any changes you make are attributed to you. 

You can do this using the workflowr function:```workflowr::wflow_git_config``` (documentation [here](https://jdblischak.github.io/workflowr/reference/wflow_git_config.html))

For example: 

```
workflowr::wflow_git_config(
                             user.name = "", #put your gitlab username here
                             user.email = "") #put your gitlab email here
```


### (2) Starting the workflowr project

This step will be different depending on the stage your project is at. In general, you should perform this step when your repository is your current working directory (as the default for directory is "."). If you have already got files in this repository, it is important that you set existing = FALSE, and overwrite = FALSE so none of your file are overwritten. 

For more detailed advice you should look at the setting up vignette relevant to your specific level of project development (starting from stratch [here](https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html), existing project but not workflowr project [here](https://jdblischak.github.io/workflowr/articles/wflow-03-migrating.html)  . 

```
workflowr::wflow_start(
  directory = “.”, 
  existing = FALSE,
  overwrite = FALSE)

```

This will create (if they aren't already there) the folders ```analysis``` and ```public```. These folders should not be deleted or renamed. The ```analysis``` subfolder is designed to contain the rmarkdown documents of your analysis, and the ```public``` subfolder is deigned to contain the. Generally, you shouldn't need to manually change anything in the public subfolder. 

Depending on what settings you use with ```wflow_start```, this step could also create the optional (can be deleted) folders ```code```, ```data```, and ```output```. The ```data``` folder is designed to contain your raw data files (and any relevant READMEs), wherease the ```output``` folder is designed to contain data files you have performed analysis on, or modified in some way. The ```code``` subfolder is designed to contain code for which the ```analysis``` folder wouldn't be appropriate, for example, for scripts containing functions you use across multiple analyses/ rmarkdown files. 

### (3) Getting workflowr to work with the unimelb gitlab 

(... or whatever institution-based gitlab you are using)

To make sure your repository is submitted to the right gitlab group, and the generated webpage matches this, you need to tell workflowr what domain name, and group name to submit the project to. You can do this using ```wflow_use_gitlab``` (documentation [here](https://jdblischak.github.io/workflowr/reference/wflow_use_gitlab.html))

```
workflowr::wflow_use_gitlab(
username = 'group_name’,  #set the group the webpage and project should be under
repository = 'pop_spec_eqtl_ml’, #put your project name
domain = 'gitlab.unimelb.edu.au’) #set it to unimelbs gitlab and not general gitlab

```
<p> </p>

---

<p> </p>

## **Using workflowr** (after set up)

Setting up workflowr should only need to be done once per computer. Once that is done, you will likely only use the following three functions:

1. ```workflowr::wflow_build() #create + view html files from .Rmd files in the analysis subfolder```
2. ```workflowr::wflow_publish() #commit changes to.Rmd and then build html files```
3. ```workflowr::wflow_git_push() #upload your changes to the remote repository```

For more information on these functions see their documentation [here](https://jdblischak.github.io/workflowr/reference/index.html)

<p> </p> 

---

<p> </p> 
