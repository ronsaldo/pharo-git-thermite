Class {
	#name : #ThVisHowToReportABugWorldMenu,
	#superclass : #ThVisAbstractWorldMenu,
	#category : 'Thermite-Card-Menu'
}

{ #category : #'world menu' }
ThVisHowToReportABugWorldMenu class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'How To Contribute')
			order: 0.002; 
			parent: self projectName asSymbol;
			label: 'How To report a bug';
			icon: (Smalltalk ui icons iconNamed: #smallDebug);
			action: [ WebBrowser openOn: 'https://github.com/ronsaldo/pharo-git-thermite/issues' ]
]
