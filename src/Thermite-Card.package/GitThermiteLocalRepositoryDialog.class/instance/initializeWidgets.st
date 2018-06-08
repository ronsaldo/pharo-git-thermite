initialization
initializeWidgets
	self title: 'Visualize Local Commit'.
	
	localRepositoryPathLabel := self newLabel.
	localRepositoryPath := self newTextInput.
	localRepositoryPath autoAccept: true.
	localRepositoryPathBrowseButton := self newButton.
	localRepositoryPathLabel label: 'Local Repository Path:'.
	localRepositoryPathBrowseButton label: '...'.
	
	commitShaLabel := self newLabel.
	commitSha := self newTextInput.
	commitSha autoAccept: true; text: 'master'.
	commitShaLabel label: 'Commit Name:'.

	parentCommitShaLabel := self newLabel.
	parentCommitSha := self newTextInput.
	parentCommitSha autoAccept: true; text: '~1'.
	parentCommitShaLabel label: 'Parent Commit Name'.

	languageLabel := self newLabel.
	language := self newDropList.
	languageLabel label: 'Language:'.
	language
		items: ThVisCardCodeAnalysisBlueprintBuilder allSubclasses;
		displayBlock: [ :b | b languageName ].
	
	addUnchangedLines := self newCheckBox.
	addUnchangedLines label: 'Add unchanged lines'.
	
	addUnmodifiedMethods := self newCheckBox.
	addUnmodifiedMethods label: 'Add unchanged methods'.
	
	addUnmodifiedClasses := self newCheckBox.
	addUnmodifiedClasses label: 'Add unchanged classes'.
	
	buildVisualizationButton := self newButton.
	buildVisualizationButton label: 'Build Visualization'.
	
	mcDiffButton := self newButton.
	mcDiffButton label: 'MC Diff'.