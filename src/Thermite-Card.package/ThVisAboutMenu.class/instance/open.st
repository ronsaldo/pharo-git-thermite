instance creation
open
	| v labels |
	v := RTView new.
	labels := RTLabel
		elementsOn:
			#('Git Thermite is a tool for analyzing Git commits and GitHub pull requests.').

	v add: labels.
	RTVerticalLineLayout on: labels.
	TRConstraint move: v elements first onTheLeftOf: labels.


	"Adding animation"
	v openTitled: 'Git Thermite - Commit and pull request analysis tool'