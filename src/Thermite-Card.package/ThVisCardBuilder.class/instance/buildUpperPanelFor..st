as yet unclassified
buildUpperPanelFor: visitCard
	| upperPanel aName kind difficultyToIntegrate innerElements pullRequest pullRequestType difficultyColor difficultyTooltip |
	pullRequest := visitCard pullRequest.
	
	upperPanel := RTBox element.
	view add: upperPanel.
	aName := (self label: pullRequest title) element.
	pullRequestType := self guessPullRequestType: pullRequest.
	
	kind := (self label: pullRequestType color: self palette importantTextColor) element.
	pullRequest mergeable ifNil: [
		difficultyColor := self palette mergeabilityUnknownColor.
		difficultyTooltip := 'Automatic merge possibility is unknown.'.
	] ifNotNil: [:mergeable |
		mergeable ifTrue: [
			difficultyColor := self palette mergeablePullRequestColor.
			difficultyTooltip := 'Automatic merge is possible.'.
		] ifFalse: [
			difficultyColor := self palette unmergablePullRequestColor.
			difficultyTooltip := 'Automatic merge is not possible.'.
		]
	].

	difficultyToIntegrate := RTBox new
		size: 15;
		color: difficultyColor;
		element.
	difficultyToIntegrate addInteraction: (RTPopup text: difficultyTooltip).
		
	innerElements := { aName . kind . difficultyToIntegrate }.
	view addAll: innerElements.
	RTHorizontalLineLayout new center; on: innerElements.
	RTNest new
        on: upperPanel nest: innerElements.
	visitCard width: upperPanel width.
	^ upperPanel