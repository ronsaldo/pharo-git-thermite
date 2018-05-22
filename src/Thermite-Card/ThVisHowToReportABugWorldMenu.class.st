Class {
	#name : #ThVisHowToReportABugWorldMenu,
	#superclass : #ThVisAbstractWorldMenu,
	#category : #'Thermite-Card-Menu'
}

{ #category : #'world menu' }
ThVisHowToReportABugWorldMenu class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'How To Contribute')
			order: 0.002; 
			parent: self projectName asSymbol;
			label: 'How To report a bug';
			icon: (Smalltalk ui icons iconNamed: #smallDebug);
			action: [ self new open.  WebBrowser openOn: 'https://github.com/ronsaldo/PharoGitHubAPI/issues'  ]
]

{ #category : #'instance creation' }
ThVisHowToReportABugWorldMenu >> open [
	"
	self new open
	"
	| v labels |
	v := RTView new.
	labels := RTGroup new.
	labels
		add:
			(RTLabel
				elementOn: 'Problems and bugs can be reported on:').
				

	labels
		add:
			((RTLabel new color: Color veryVeryDarkGray)
				elementOn: 'https://github.com/ronsaldo/pharo-git-thermite/issues').
				
	v add: labels.
	RTVerticalLineLayout on: labels.


	"Adding animation"
	v openInWindowSized: 600 @ 400 titled: 'GitStats - GitHub Analysis Tool'
]
