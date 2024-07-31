---
title: 'Research'
date: 2024-05-19
type: landing

design:
  # Section spacing
  spacing: '5rem'
  
# Page sections
sections:
  - block: markdown
    content:
      title: 'Research Projects Overview'
      subtitle: ''
      text: |-
        My current research explores the impact of different metrics on the portability of one type of genetic association: expression quantitative trait loci (eQTLs). This work builds on  insights gained during <a href="/project/pop_spec_eqtl/"  style="color:#D90429"> my master's research at Melbourne University</a>; while training machine learning models to predict eQTL portability across human populations, I realised power was a significant confounder to the accurate interpretation of many studies.
        
        Before my master's, I contributed to work testing two evolutionary theories at Monash University  (<a href= "/project/monash_journalclub/" style="color:#D90429">'Unguarded X'</a> and <a href= "/project/monash-winter/" style="color:#D90429"> genomic location of maintained sexually antagonistic variants</a>). Additionally, researchers at WEHI shaped my coding practices by supervising my undergraduate research project: adapting a Bayesian model and R-package for testing differential mRNA abundance (<a href="/project/tabi/" style="color:#D90429">TABI</a>).

  - block: collection
    id: publications
    content: 
      title: 'Recent Publications'
      text: ' '
      filters:
        folders:
          - publication
    design:
      view: card
      fill_image: true
      columns: 2
  - block: collection
    id: talks
    content: 
      title: Recent Conference Talks & Posters
      text: ' '
      filters:
        folders:
          - event
    design:
      view: card
      fill_image: false
      columns: 1
  - block: collection
    id: projects
    content: 
      title: Research Projects
      text: ' '
      filters:
        folders:
          - project
    design:
      view: article-grid
      fill_image: false
      columns: 3
---

        
        
 
        
        
       
        

