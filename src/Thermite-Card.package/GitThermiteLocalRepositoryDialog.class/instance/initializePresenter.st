initialization
initializePresenter
	localRepositoryPathBrowseButton action: [ self browseLocalRepository ].
	buildVisualizationButton action: [ self buildVisualization ].
	mcDiffButton action: [ self mcDiff ]
	