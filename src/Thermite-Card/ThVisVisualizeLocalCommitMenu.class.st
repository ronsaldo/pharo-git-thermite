Class {
	#name : #ThVisVisualizeLocalCommitMenu,
	#superclass : #ThVisAbstractWorldMenu,
	#category : #'Thermite-Card-Menu'
}

{ #category : #'world menu' }
ThVisVisualizeLocalCommitMenu class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: (self projectName , ' Visualize Local Commit') asSymbol)
			order: 0.1; 
			parent: self projectName asSymbol;
			label: 'Visualize local commit';
			action: [ self new open ]
]

{ #category : #'instance creation' }
ThVisVisualizeLocalCommitMenu >> open [
	GitThermiteLocalRepositoryDialog new openWithSpec.
]
