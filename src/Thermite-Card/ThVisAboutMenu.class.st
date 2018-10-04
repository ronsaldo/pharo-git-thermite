Class {
	#name : #ThVisAboutMenu,
	#superclass : #ThVisAbstractWorldMenu,
	#category : 'Thermite-Card-Menu'
}

{ #category : #'world menu' }
ThVisAboutMenu class >> menuCommandOn: aBuilder [
	<worldMenu>
	((aBuilder item: self projectName asSymbol))
	withSeparatorAfter;
	with: [
		(aBuilder item: ('About ', self projectName) asSymbol)
				order: 0.001; 
				parent: self projectName asSymbol;
				label: 'About ', self projectName;
				icon: (Smalltalk ui icons iconNamed: #smallLanguageIcon);
				action: [ self new open ]
	]
]

{ #category : #'instance creation' }
ThVisAboutMenu >> open [
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
]
