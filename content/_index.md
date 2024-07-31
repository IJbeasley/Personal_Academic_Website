---
title: "Hello"
type: landing

sections:
  - block: hero
    content:
      title: "Hi, I'm Isobel!"
      text: "Interdisciplinary Master of Science Graduate"
      primary_action:
        text: Get Started
        url: https://hugoblox.com/templates/
        icon: rocket-launch
      secondary_action:
        text: Read the docs
        url: https://docs.hugoblox.com
  - block: markdown
    content:
      title: '📚 My Research'
      subtitle: ''
      text: |-
        Use this area to speak to your mission. I'm a research scientist in the Moonshot team at DeepMind. I blog about machine learning, deep learning, and moonshots.

        I apply a range of qualitative and quantitative methods to comprehensively investigate the role of science and technology in the economy.

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
---