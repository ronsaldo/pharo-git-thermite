# Pharo Git Thermite
#### A visual tool for assessing Git commits and GitHub Pull Requests

## Installation

The following script installs Git Thermite:

```smalltalk
Metacello new
   baseline: 'Thermite';
   repository: 'github://ronsaldo/pharo-git-thermite/src';
   load
```

## Usage

### Visualizing a local git commit

For visualizing a local Git commit, you can use the dialog in the **World Menu -> Git Thermite -> Visualize local commit**. 

### Visualizing a GitHub pull request

For visualizing a GitHub pull request, you can use the dialog in the **World Menu -> Git Thermite -> Visualize pull request**.

### Visualizing Monticello commits

Pharo Git Thermite adds some additional buttons into the Monticello Repository Browser. The **Thermite changes** buttons allows you to visualize the changes introduced by a single monticello commit using Pharo Git Thermite. The **Thermite parent changes** button allows you to select a parent commit for comparing using Pharo Git Thermite.

## Feedback form

For giving feedback on Git Thermite, you can use the [Google form.](https://docs.google.com/forms/d/e/1FAIpQLSeir6VlE3bR78oRsNAp9eHLkUn2Q016wEliOJN7tFlTmYFi8w/viewform?usp=sf_link)
