initialization
initializeWidgets
	self title: 'Visualize GitHub Pull Request'.
	
	projectOwnerLabel := self newLabel.
	projectOwner := self newTextInput.
	projectOwner
		autoAccept: true;
		aboutText: 'Here goes the GitHub project owner name'.
	projectOwnerLabel label: 'GitHub Project Owner:'.
	
	projectNameLabel := self newLabel.
	projectName := self newTextInput.
	projectName autoAccept: true.
	projectNameLabel label: 'GitHub Project Name:'.

	pullRequestNumberLabel := self newLabel.
	pullRequestNumber := self newTextInput.
	pullRequestNumber autoAccept: true.
	pullRequestNumberLabel label: 'GitHub Pull Request Number:'.

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
	