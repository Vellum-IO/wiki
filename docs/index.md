---
layout: home

hero:
  name: "Vellum IO Wiki"
  text: "Standards, Research & Documentation"
  tagline: Organizational standards, research notes and documentation
  actions:
    - theme: brand
      text: Browse Documentation
      link: /keeper/architecture
    # - theme: alt
    #   text: View Research
    #   link: /identity-provider
# features:
#   - title: Organizational Standards
#     details: Guidelines and best practices we follow at Vellum IO
#   - title: Software Research
#     details: Notes from testing different tools and technologies in practice
#   - title: Comparisons
#     details: Pros and cons of solutions we've tried, like Identity Providers and Kubernetes CNIs
---

<script setup>
import { VPTeamMembers } from 'vitepress/theme'

const members = [
  {
    avatar: 'https://github.com/tom-ludwig.png',
    name: 'Tom Ludwig',
    title: 'Maintainer',
    links: [
      { icon: 'github', link: 'https://github.com/tom-ludwig' }
    ]
  },
  {
    avatar: 'https://github.com/louis-kauer.png',
    name: 'Louis Kauer',
    title: 'Maintainer',
    links: [
      { icon: 'github', link: 'https://github.com/louis-kauer' }
    ]
  }
  // Add more team members as needed
]
</script>

## About This Wiki

// TODO:

## Team

<VPTeamMembers :members="members" />
