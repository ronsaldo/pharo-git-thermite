Class {
	#name : #ThVisExampleLocalWorldMenu,
	#superclass : #ThVisAbstractWorldMenu,
	#category : #'Thermite-Card-Menu'
}

{ #category : #'world menu' }
ThVisExampleLocalWorldMenu class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: (self projectName , ' Examples') asSymbol)
			order: 0.1; 
			parent: self projectName asSymbol;
			label: self projectName , ' local examples';
			action: [ self new open ]
]

{ #category : #'instance creation' }
ThVisExampleLocalWorldMenu >> open [
	Workspace new
	contents: '"DoIt:"
repo := GitStatsRepository path: ''<cloned repository path>''.
commit := repo commit: ''<Commit name or SHA>''.

"Inspect:"
builder := GSCardBuilder new.
builder pythonCodeAnalyzer. "Or pharoCodeAnalyzer"
builder
    addCommit: commit;
    vertical;
    draggable;
    view.
';
	openLabel: 'GitStats example'
]
