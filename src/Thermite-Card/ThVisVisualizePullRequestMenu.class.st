Class {
	#name : #ThVisVisualizePullRequestMenu,
	#superclass : #ThVisAbstractWorldMenu,
	#category : 'Thermite-Card-Menu'
}

{ #category : #'world menu' }
ThVisVisualizePullRequestMenu class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: (self projectName , ' Visualize Pull Request') asSymbol)
			order: 0.1; 
			parent: self projectName asSymbol;
			label: 'Visualize pull request';
			action: [ self new open ]
]

{ #category : #'instance creation' }
ThVisVisualizePullRequestMenu >> open [
	GitThermiteGitHubRepositoryDialog new openWithSpec.

]
