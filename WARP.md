# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a Jekyll-based academic research website for the Permuta Triangle research group, focused on the combinatorics of permutation patterns. The site showcases research papers, programs, projects, and team members in the field of permutation theory and combinatorial mathematics.

## Development Environment Setup

### Prerequisites
- Ruby (version compatible with Jekyll)
- Bundler gem manager
- Jekyll static site generator

### Installation
```bash
# Install required gems
bundle install

# Serve the site locally for development
bundle exec jekyll serve

# Build the site for production
bundle exec jekyll build
```

Note: If you encounter bundler version issues, run:
```bash
gem install bundler:2.0.2
# or
bundle update --bundler
```

## Site Architecture

### Jekyll Collections
The site uses Jekyll collections to organize different types of content:

- `_authors/` - Research group members and collaborators
- `_papers/` - Academic papers and publications  
- `_programs/` - Software projects (Permuta, Tilings, ComboPal)
- `_projects/` - Research projects
- `_talks/` - Conference presentations and talks
- `_posts/` - Blog posts and news updates

### Key Configuration
- **Theme**: Minima
- **Plugins**: jekyll-feed, github-pages
- **Collections**: All collections have `output: true` for individual pages
- **Layouts**: Custom layouts for each collection type (paper.html, author.html, etc.)

### Content Structure

#### Authors
Author files in `_authors/` use frontmatter:
- `status` - member, student, collaborator
- `short_name` - used for references in papers
- `first_name`, `name` - display names
- `position` - academic position

#### Papers  
Paper files in `_papers/` include:
- `title` - paper title
- `journal` - publication venue
- `authors` - array of author short_names
- `projects` - related research projects
- Content includes abstract, updates, download links, presentations

#### Programs
Software project documentation in `_programs/` for:
- **Permuta** - Python library for permutation patterns
- **Tilings** - Library for gridded permutations and tilings
- **ComboPal** - Combinatorial pattern analysis tool

### Navigation and Data
- `_data/navigation.yml` - Site navigation menu
- `_includes/navigation.html` - Navigation component
- Cross-references between collections using author short_names

## Common Development Tasks

### Adding New Content

**New Paper:**
```bash
# Create file: _papers/YYYY-MM-DD-shortname.md
# Follow existing frontmatter format with authors array
```

**New Author:**
```bash  
# Create file: _authors/shortname.md
# Set status: member/student/collaborator
# Use short_name consistently across papers
```

**New Program/Software:**
```bash
# Create file: _programs/YYYY-MM-DD-name.md
# Include repo links and installation instructions
```

### Local Development
```bash
# Start development server with live reload
bundle exec jekyll serve --livereload

# Build and check links
bundle exec jekyll build
# Site builds to _site/ directory
```

### Asset Management
- Images: `/assets/img/` (paper figures, author photos)
- PDFs: `/assets/talks/` (presentation slides)
- CVs: `/assets/cvs/` (curriculum vitae files)

## Related Codebases

This research group maintains several related software projects:
- **Permuta** (`/Users/henningu/github_repos/Permuta`) - Python permutation library
- **Tilings** (`/Users/henningu/github_repos/Tilings`) - Gridded permutation library  
- **CayleyPerms** (`/Users/henningu/github_repos/CayleyPerms`) - Related permutation tools

These codebases are often referenced in the `_programs/` collection and may be linked from papers and research descriptions.

## Content Guidelines

- Use author `short_name` consistently across all collections
- Papers should include arXiv and journal links when available
- Include presentation materials and update sections for ongoing research
- Programs should have clear installation and usage examples
- Maintain consistent date formatting: YYYY-MM-DD in filenames

## GitHub Pages Deployment

The site is configured for GitHub Pages deployment using:
- `github-pages` gem in Gemfile
- Jekyll compatible plugins only
- Assets served from `/assets/` directory
- Custom 404 page available