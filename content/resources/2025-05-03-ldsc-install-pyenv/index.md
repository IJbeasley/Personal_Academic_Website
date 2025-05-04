---
title: 'Easier Installation of LDSC with pyenv'
author: 'Isobel Beasley'
date: '2025-05-03'
slug: ldsc-install
categories: ['Resources', 'Research', 'Coding']
tags: ['code', 'LDSC', 'pyenv', 'python', 'installation', 'bioinformatics challenges']
subtitle: ''
summary: 'A step-by-step guide for installing LD Score Regression (LDSC) and its dependencies on HPC systems using pyenv instead of Conda 
- which may save you some headaches.'
authors: ['Isobel Beasley']
lastmod: '2025-05-03T23:40:24-07:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

I ran into a lot of issues installing LDSC using Conda on UCSF’s HPC, 
following their recommended steps. My supervisor suggested using **pyenv** instead, 
and that worked—quickly and painlessly. 
So I thought I’d share the exact steps I followed in case it helps someone else.

## 1. Install and Configure Pyenv

First, I needed to get pyenv working on the HPC cluster:

```{bash}

# initial install step
curl https://pyenv.run | bash

# restart shell
exec "$SHELL"

# ensure pyenv is added to PATH
# by adding lines to ~/.bashrc 
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# restart shell
exec "$SHELL"

# check installation worked
pyenv --version


```


## 2. Make pyenv virtual environment for LDSC


Now we set up a virtual environment that matches LDSC dependencies, as listed in their [environment.yml](https://github.com/bulik/ldsc/blob/master/environment.yml).

```{bash}

# Replace my_virtual_env_name with whatever virtual environment 
# name makes sense for you
# 2.7 refers to python 2.7 - as asked for in the environment.yml
pyenv virtualenv 2.7 my_virtual_env_name

# activate the virtual environment
pyenv activate my_virtual_env_name

# now, one by one pip install the packages listed in environment.yml
pip install scipy==0.18
pip install pandas==0.20
pip install numpy==1.16
pip install bitarray==0.8
pip install nose==1.3
pip install pybedtools==0.7

# check virtual environment matches environment.yml
pip list


```

## 3. Clone and Set Up LDSC


```{bash}

# navigate to where you want to copy the ldsc repository software 
git clone https://github.com/bulik/ldsc.git

cd ldsc


```


## 4. Test Your LDSC Installation


```{bash}

# make sure the right pyenv virtual environment is activated
# then look at the help information for ldsc scripts

ldsc.py -h
munge_sumstats.py -h


```

