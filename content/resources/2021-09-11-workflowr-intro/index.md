---
weight: 2
title: Using workflowr and gitlab with R projects
author: ''
date: '2021-09-11'
slug: workflowr-intro
categories: ['resources', 'research']
tags: ['R', 'workflowr']
subtitle: ''
summary: 'An introduction to using workflowr with a university or institutional gitlab account'
authors: []
lastmod: '2023-11-05T04:23:36+11:00'
featured: yes
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

I originally wrote the information below as a master's student in 2021. I wrote it intending to help fellow lab fellow lab members with less experience with R and git to start using workflowr to produce reproducible documentation of their data analyses. I've added it here as I thought it may also be helpful to a broader audience: anyone with a little bit of experience in R coding who is ready to expand their skills into R projects and git should find some information below useful. 

<br>
<br>

## What is workflowr? 

```workflowr``` is an R package for documenting analyses of data in a way that is shareable, reproducible, organised and trackable. Specifically, it builds a webpage that you can share with others, from a set of rmarkdown documents. An example webpage, showing how I've used workflowr for bioinformatic analyses can be found  [here](https://igr-lab.pages.gitlab.unimelb.edu.au/pop_spec_eqtl_ml/index.html).

### Introductory resources 

For a good introduction to the ```workflowr``` package, you can watch the following [video](https://www.youtube.com/watch?v=GrqM2VqIQ20&ab_channel=RConsortium). Additionally, you should check out the [workflowr GitHub page](https://workflowr.github.io/workflowr/index.html) and in particular the workflowr [getting started vingette](https://workflowr.github.io/workflowr/articles/wflow-01-getting-started.html). If you are unfamiliar with rmarkdown, there's plenty of information available online, including documentation [here](https://bookdown.org/yihui/rmarkdown) and a brief introductory video [here](https://www.youtube.com/watch?v=DNS7i2m4sB0&ab_channel=RogerPeng).


<p> </p> 

<br>
<br>
<p> </p>

## What if I am unfamilar with git?  

The [workflowr R package](https://workflowr.github.io/workflowr/index.html) uses git behind the scenes. Good bioinformatics practices and most current computational research also relies upon git. Thus, although the ideas behind git and some git 'lingo' may seem foreign, becoming familiar with these aspects is a valuable research skill. To better understand these concepts when I first started using git, I found [this lecture course helpful](https://missing.csail.mit.edu/2020/version-control/) from [MIT's The Missing Semester of Your CS Education](https://missing.csail.mit.edu/)

## What is git?

Briefly speaking, git is a widely used version control software. Git tracks changes that occur to a group of files over time. Each change (or group of changes) you want to track is **commited** (think 'commitment'), alongside information about who decided to track this change and when they decided this. Additionally, each time you 'commit' to a change, you should write a short message explaining *what this change was* and *why you made this change*. A group of files tracked together is called a **repository** (or project if using GitLab). The repository is usually just the 'big' folder containing all the files and subfolders you want to track together. 
There are always multiple copies of git projects / repositories. At a minimum, there is the copy you have on your computer or on HPC cluster (called the local version), and the copy on gitlab (or github). Any time you commit to changes on your local copy, you can upload these changes to the copy on gitlab by pushing them. 

There are always multiple copies of git projects/repositories. At a minimum, there is the **'local'** copy on your computer (or on an HPC cluster) and the **'remote'** copy on Gitlab (or GitHub). Any time you commit to changes on your local copy, you can upload them to the remote copy on GitLab by **'pushing'** them. 

## .gitignore files

Since there are particular types of files you do not want git to track (e.g., data, trust, and learn from my experience - you *really *do not want git to track data), you will likely want to safeguard yourself from accidentally committing (tracking) these files. To do this, you can add a .gitignore file in your repository (example .gitignore file [here](https://gitlab.unimelb.edu.au/igr-lab/pop_spec_eqtl_ml/-/blob/master/.gitignore)).

A ```.gitignore``` file is essentially a list of the types of files or folders you would like git to ignore. Once you have added these file types to your .gitignore file (and committed this change to your .gitignore file!), it is quite hard to track these file types accidentally. For example, if your .gitignore file contains ```*.csv```, this tells git to ignore all csv files in your repository. If you now try to add a commit to a folder that contains this file - git will track the folder and its contents, but not any ```*.csv```files in this folder. If you'd like your git to ignore a folder called data, you can use ```**/data```. For different ways of telling git to ignore things, see this [webpage](https://www.atlassian.com/git/tutorials/saving-changes/gitignore).  
Furthermore, from [this example file](https://gitlab.unimelb.edu.au/igr-lab/pop_spec_eqtl_ml/-/blob/master/.gitignore), you'll notice that I avoid tracking changes to cached files (```py_cache```), and slurm ```.out``` files. I made these changes because I know you should only track relatively small files (<100 MB, but generally, each file should be much smaller than this), and generally, files you'd be very sad to lose. Cache files are pretty forgettable, and ```.out``` files do not change over time, so I'm not interested in tracking these files. 

<p> </p> 


<br>
<br>
<p> </p>


## Starting with workflowr

Exactly how you start using workflowr will depend on what stage the project you are working on is at. If you haven't already, you will need to configure git first. Only once you have correctly configured git can you initialise the workflowr project. **Importantly, to get your workflowr page to be uploaded and published on an institutional GitLab group page (e.g. The University of Melbourne's GitLab, gitlab.unimelb.edu.au) you need to perform an unusual extra step (3)**. 


### (0) Create a repository ('project')

If you haven't already created a repository, you should first make a new folder, give it an informative name, and then navigate to this folder. This new folder should be the 'big' folder, eventually containing all the files and folders you'd like to track together. 

### (1) Configure git 

If you haven't already, sign up for a GitLab or GitHub account you want to use for the project. You should then configure (tell) git your GitLab user name and email address so any changes you make are attributed to you. 
You can do this using the workflowr function:

```workflowr::wflow_git_config``` 

(documentation [here](https://workflowr.github.io/workflowr/reference/wflow_git_config.html))

For example: 

```
workflowr::wflow_git_config(
                             user.name = "", #put your GitLab username here
                             user.email = "") #put your GitLab email here
```


### (2) Starting the project

This step will be different depending on the stage your project is at. In general, you should perform this step when your repository is your current working directory (as the default for directory is "."). If you already have files in this repository, it is essential that you set ```existing = FALSE````and ```overwrite = FALSE```. Making these settings will ensure you do not overwrite any existing files.

For more detailed advice, look at the setting up vignettes on the workflowr documentation page. There will be one precisely relevant to your specific level of project development:  if you are [starting from scratch](https://jdblischak.github.io/workflowr/articles/wflow-01-getting-started.html), existing project but not workflowr project [here](https://jdblischak.github.io/workflowr/articles/wflow-03-migrating.html). 

```
workflowr::wflow_start(
  directory = “.”, 
  existing = FALSE,
  overwrite = FALSE)

```
Running this code will create (if they aren't already there) the folders ```analysis``` and ```public```. These folders should not be deleted or renamed. The ```analysis``` subfolder is designed to contain the rmarkdown documents of your analysis, and the ```public``` subfolder is designed to contain the. In most cases, you won't need to manually change anything in the public subfolder (please only make changes if you are sure about what you are doing!). 

Depending on your ```wflow_start``` settings, this step could also create the optional (can be deleted) folders: ```code```, ```data```, and ```output```. The ```data``` folder is supposed to contain your raw data files (and any relevant READMEs), whereas the ```output``` folder is designed to contain data files you have performed analysis on or modified somehow. The ```code``` subfolder is designed to contain code for which the ```analysis``` folder wouldn't be appropriate, for example, for scripts containing functions you use across multiple analyses/rmarkdown files. 

### (3) Get workflowr to work with gitlab 

For Melbourne University ... or whatever institution-based GitLab you are using

To ensure you submit your repository to the right GiLab group and the generated webpage matches this, you need to tell the workflowr your project's domain name and group name. You can do this using ```wflow_use_gitlab``` (documentation [here](https://workflowr.github.io/workflowr/articles/wflow-06-gitlab.htmll))

```
workflowr::wflow_use_gitlab(
username = 'group_name’,  #set the group the webpage and project should be under
repository = 'pop_spec_eqtl_ml’, #put your project name
domain = 'gitlab.unimelb.edu.au’  #set it to unimelbs GitLab and not general GitLab
                          )


```
<p> </p>

---

<p> </p>
<br>
<br>

## Using workflowr

Setting up workflowr should only need to be done once per computer. Once you have done that, you will likely only use the following three functions:

1. ```workflowr::wflow_build() #create + view html files from .Rmd files in the analysis subfolder```
2. ```workflowr::wflow_publish() #commit changes to.Rmd and then build html files```
3. ```workflowr::wflow_git_push() #upload your changes to the remote repository```

For more information on these functions see their documentation [here](https://workflowr.github.io/workflowr/reference/index.html)

<p> </p> 

---

<p> </p> 
