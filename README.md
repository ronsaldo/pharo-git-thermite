# Pharo Git Thermite
#### A visual tool for assessing Git commits and GitHub Pull Requests

![Git Thermite Visualization](doc/img/thermite-visualization.png?raw=true "Git Thermite Visualization")

## Installation

The following script installs Git Thermite in a Pharo 6.1 image:

```smalltalk
Metacello new
   baseline: 'Thermite';
   repository: 'github://ronsaldo/pharo-git-thermite/src';
   load
```

## Usage

### Visualizing a local git commit

For visualizing a local Git commit, you can use the dialog in the **World Menu -> Git Thermite -> Visualize local commit**.

![Visualize local commit menu](doc/img/visualize-local-commit-menu.png?raw=true "Visualize local commit menu")

![Visualize local commit dialog](doc/img/visualize-local-commit.png?raw=true "Visualize local commit dialog")

In this dialog **Local Repository Path** is the path for a locally cloned git repository. **Commit Name** is the name of a git commit (or branch, tag, etc) as accepted by git. **Parent Commit Name** is the name of the commit to use for comparing against. By default this is set to **~1** which is a git notation for
naming the immediate parent of the commit present in the **Commit Name** text input field.

### Visualizing a GitHub pull request

For visualizing a GitHub pull request, you can use the dialog in the **World Menu -> Git Thermite -> Visualize pull request**.

![Visualize Pull Request Menu](doc/img/visualize-pull-request-menu.png?raw=true "Visualize Pull Request Menu")

![Visualize Pull Request Dialog](doc/img/visualize-pull-request.png?raw=true "Visualize Pull Request Dialog")

In this dialog **GitHub Project Owner** is the name of the owner of the GitHub repository to analyze. **GitHub Project Name** is the name of the GitHub project to analyze.

### Visualizing Monticello commits

Pharo Git Thermite adds some additional buttons into the Monticello Repository Browser. The **Thermite changes** buttons allows you to visualize the changes introduced by a single monticello commit using Pharo Git Thermite. The **Thermite parent changes** button allows you to select a parent commit for comparing using Pharo Git Thermite.

![Monticello Thermite Buttons](doc/img/thermite-monticello.png?raw=true "Monticello Thermite Buttons")

### Legend

![Legend](doc/img/legend.png?raw=true "Legend")

## Feedback form

For giving feedback on Git Thermite, you can use the [Google form.](https://docs.google.com/forms/d/e/1FAIpQLSeir6VlE3bR78oRsNAp9eHLkUn2Q016wEliOJN7tFlTmYFi8w/viewform?usp=sf_link)
