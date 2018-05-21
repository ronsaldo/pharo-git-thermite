Class {
	#name : #ThVisCardBuilder,
	#superclass : #Object,
	#instVars : [
		'view',
		'visitCards',
		'codeAnalyzer',
		'currentVisitCard',
		'palette',
		'navigationButtons',
		'pullRequests',
		'useStackBarPlot',
		'withoutUnchangedLines'
	],
	#classVars : [
		'FileChartHeight',
		'FileChartWidth'
	],
	#category : #'Thermite-Card'
}

{ #category : #initialization }
ThVisCardBuilder class >> initialize [
	super initialize.
	
	FileChartHeight := 25.0.
	FileChartWidth := FileChartHeight *0.25.

]

{ #category : #accessing }
ThVisCardBuilder >> addCommit: commit [
	self flag: 'FIXME: hack for supporting local repositories'.
	self addPullRequest: commit
]

{ #category : #accessing }
ThVisCardBuilder >> addMonticelloPackage: packageName from: oldVersion to: newVersion [
	self addMonticelloPackage: packageName from: oldVersion to: newVersion title: 'Monticello Changes'
]

{ #category : #accessing }
ThVisCardBuilder >> addMonticelloPackage: packageName from: oldVersion to: newVersion title: aTitle [
	| oldVersionRingPackage newVersionRingPackage fakeCommit |
	oldVersionRingPackage := oldVersion asRingPackageNamedForThermite: packageName.
	newVersionRingPackage := newVersion asRingPackageNamedForThermite: packageName.
	fakeCommit := ThStatsMonticelloDiff new
		title: aTitle;
		oldPackages: { oldVersionRingPackage };
		newPackages: { newVersionRingPackage };
		yourself.
	self addCommit: fakeCommit.
]

{ #category : #adding }
ThVisCardBuilder >> addNavigation: label text: textBlock [
	self addNavigation: label text: textBlock priority: 0
]

{ #category : #adding }
ThVisCardBuilder >> addNavigation: label text: textBlock priority: priority [
	textBlock ifNil: [ ^ self ].
	self addNavigationButtonWithModel: (ThVisNavigationButtonTextBlockModel new label: label; text: textBlock) priority: priority.
]

{ #category : #adding }
ThVisCardBuilder >> addNavigation: label view: viewBlock [
	self addNavigation: label view: viewBlock priority: 0
]

{ #category : #adding }
ThVisCardBuilder >> addNavigation: label view: viewBlock priority: priority [
	viewBlock ifNil: [ ^ self ].
	self addNavigationButtonWithModel: (ThVisNavigationButtonViewBlockModel new label: label; view: viewBlock) priority: priority.
]

{ #category : #adding }
ThVisCardBuilder >> addNavigationButtonWithModel: aModel [
	^ self addNavigationButtonWithModel: aModel priority: 0
]

{ #category : #adding }
ThVisCardBuilder >> addNavigationButtonWithModel: aModel priority: priority [
	| button background label enterAction leaveAction normalColor highlightColor |
	normalColor := Color veryLightGray.
	highlightColor := Color blue muchLighter.
	background := (RTBox new color: normalColor) elementOn: aModel.
	label := RTLabel new
		text: #label;
		color: self palette textColor;
		elementOn: aModel.
	enterAction := [ :ev |
		background color: highlightColor.
		ev signalUpdate
	].
	leaveAction := [ :ev |
		background color: normalColor.
		ev signalUpdate
	].

	label when: TRMouseEnter do: enterAction.
	label when: TRMouseLeave do: leaveAction.

	RTNest new on: background nest: { label }.
	button := { background . { background . label } . priority }.
	
	navigationButtons := navigationButtons , { button }
]

{ #category : #adding }
ThVisCardBuilder >> addPullRequest: pullRequest [
	| visitCardElement upperPanel middlePanel visitCard mainPanels lowerPanel |
	pullRequests add: pullRequest.
	visitCard := ThVisCard new pullRequest: pullRequest.
	view canvas color: self palette viewBackground.
	currentVisitCard := visitCard.
	visitCard commits: pullRequest commits allItems.
	visitCard treeView: [self buildCommitTreeViewFor: visitCard].
	
	visitCardElement := RTBox new color: self palette visitCardBackground; elementOn: visitCard.
	visitCardElement @ RTDraggable.
	view add: visitCardElement.

	upperPanel := self buildUpperPanelFor: visitCard.
	middlePanel := self buildMiddlePanelFor: visitCard.

	self flag: 'Improve the commit tree'.
	"self addNavigation: 'Commit Tree' view: [self buildCommitTreeViewFor: visitCard] priority: 11."
	self addNavigation: 'Diff' text: [ pullRequest diff ] priority: 10.
	 
	lowerPanel := self buildLowerPanelFor: visitCard.
	mainPanels := { upperPanel . middlePanel . lowerPanel} select: #isNotNil.

	RTVerticalLineLayout new center; on: mainPanels.

	RTNest new
        on: visitCardElement nest: mainPanels.
	visitCards add: visitCardElement.
	^ visitCardElement
]

{ #category : #accessing }
ThVisCardBuilder >> addPullRequests: pullRequests [
	pullRequests do: [ :pullRequest | self addPullRequest: pullRequest ]
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> buildCodeChangesFor: pullRequest [
	^ codeAnalyzer buildCodeChangesFor: pullRequest
	
]

{ #category : #'file view' }
ThVisCardBuilder >> buildCommitFileChangesFor: pullRequest files: files [
	| b displayedLinesSum normalizationFactor fileSize |
	b := self newMondrianBuilder.

	b interaction popupText: [:file |
		self tooltipForFile: file
	] solidBackgroundColor: self palette popupBackgroundColor.

	b shape box
		withTextAbove: #basename;
		borderColor: self palette normalNodeBorderColor;
		color: #changeColor.
	b shape shape allShapes first color: [:file | file isTest ifTrue: [ self palette testNodeBorderdColor ] ifFalse: [self palette textColor] ].
	b interaction
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.

	b nodes: (files sorted: [:a :fb | a totalNumberOfLines > fb totalNumberOfLines ]) forEach: [ :file |
		displayedLinesSum := file additions + file deletions.
		withoutUnchangedLines ifFalse: [ 
			displayedLinesSum := displayedLinesSum + file unchangedNumberOfLines
		].
	
		fileSize := displayedLinesSum sqrt*0.25.
		normalizationFactor := fileSize * FileChartHeight / (displayedLinesSum max: 1).
		 
		b shape box
			color: [:proxy | proxy metric second];
			width: FileChartWidth;
			height: [:proxy | proxy metric third].
		b interaction
			noInteractions;
			popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
		
		b nodes: ({
			withoutUnchangedLines ifFalse: [
				file proxyForMetric: {file unchangedNumberOfLines asString , ' unchanged lines' . self palette unchangedColor. file unchangedNumberOfLines*normalizationFactor}
			].
			file proxyForMetric: {file additions asString , ' additions' . self palette additionsColor . file additions* normalizationFactor}.
			file proxyForMetric: {file deletions asString , ' deletions' . self palette deletionsColor . file deletions*normalizationFactor}
		} select: [:el | el isNotNil and: [el metric third ~= 0]]).
		b layout verticalLine verticalGap: 0.
	].
	
	"b layout horizontalFlow maxWidth: currentVisitCard width asFloat."
	b layout grid.
	b build.
	
	^ b
]

{ #category : #'commit tree view' }
ThVisCardBuilder >> buildCommitTreeViewFor: visitCard [
	| b commitDictionary displayedLinesSum commitSize normalizationFactor |
	b := self newMondrianBuilder.

	commitDictionary := Dictionary new..
	visitCard commits do: [ :commit | commitDictionary at: commit sha put: commit].
	
	b interaction
		popupText: [:commit | self tooltipForCommit: commit ]
		solidBackgroundColor: self palette popupBackgroundColor.

	b shape box
		width: [:commit | commit deletions];
		height: [:commit | commit additions].
	b nodes: visitCard commits forEach: [ :commit |
		displayedLinesSum := commit additions + commit deletions.
		commitSize := displayedLinesSum sqrt*0.1.
		normalizationFactor := commitSize * FileChartWidth / (displayedLinesSum max: 1).
		b shape box
			color: #second;
			width: FileChartWidth;
			height: #third.
		b interaction
			popupText: [:el | self tooltipForCommit: commit ] solidBackgroundColor: self palette popupBackgroundColor;
			when: TRMouseLeftClick do: [ :event | commit inspect ].
		
		b nodes: ({
			{commit additions asString , ' additions' . self palette additionsColor . commit additions* normalizationFactor}.
			{commit deletions asString , ' deletions' . self palette deletionsColor . commit deletions*normalizationFactor}
		} select: [:el | el third ~= 0]).
		b layout verticalLine verticalGap: 0.
	].
	
	b edges connectToAll: [ :commit |
		commit parentsSha
			collect: [ :parentSha | commitDictionary at: parentSha ifAbsent: [ nil ] ]
			thenReject: #isNil
	].
	"b nodes: (1 to: 3).
	b edges connectToAll: [ :v | { v + 1 . v + 2 } ].
	"
	"b layout circle radius: 10."
	b layout tree.
	b build.

	^ b view
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> buildFileChangesChartFor: pullRequest [
	| files addedFiles removedFiles modifiedFiles unchangedFiles counted |
	files := codeAnalyzer filterModifiedFiles: (pullRequest numStat collect: [:rf |
		ThVisCardFileNode new
			palette: self palette;
			model: rf]).
	files ifEmpty: [ ^ #() ].
	
	self addNavigation: 'File Changes' view: [self buildCommitFileChangesFor: pullRequest files: files] priority: -10.
	
	addedFiles := OrderedCollection new.
	removedFiles := OrderedCollection new.
	modifiedFiles := OrderedCollection new.
	unchangedFiles := OrderedCollection new.
	
	files do: [ :file |
		counted := false.
		file wasAdded ifTrue: [ addedFiles add: file . counted := true ].
		file wasRemoved ifTrue: [ removedFiles add: file . counted := true ].
		file wasModified ifTrue: [ modifiedFiles add: file . counted := true ].
		counted ifFalse: [ unchangedFiles add: file ].
	].

	^ {
		self plotMetrics: {
			{ self palette additionsColor . '{1} - Added files' . addedFiles size . [self buildCommitFileChangesFor: pullRequest files: addedFiles] }.
			{ self palette deletionsColor . '{1} - Removed files' . removedFiles size . [self buildCommitFileChangesFor: pullRequest files: removedFiles] }.
			"{ self palette movementColor . '{1} - Moved classes' . movedClasses size . self visualizationForClasses: movedClasses }."
			{ self palette modifiedColor . '{1} - Modified files' . modifiedFiles size . [self buildCommitFileChangesFor: pullRequest files: modifiedFiles] }.
			withoutUnchangedLines ifFalse: [
				{ self palette unchangedColor . '{1} - Unchanged files ' . unchangedFiles size . [self buildCommitFileChangesFor: pullRequest files: unchangedFiles] }
			]
		} title: 'Files'
	}
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> buildLowerPanelFor: visitCard [
	| panel panelElements label buttonsPanel buttons |
	navigationButtons ifEmpty: [ ^ nil ].
	navigationButtons sort: [ :a :b | a third <= b third ].
	panel := RTBox element.
	view add: panel.

	label := (self label: 'Visualizations') element.
	view add: label.
	panelElements := {label}.
	
	buttonsPanel := RTBox element.
	view add: buttonsPanel.

	navigationButtons do: [ :but | view addAll: but second ].
	buttons := navigationButtons collect: #first.
	RTHorizontalLineLayout on: buttons.
	"RTGridLayout on: buttons."
	
	RTNest new
        on: buttonsPanel nest: buttons.
	panelElements := panelElements , { buttonsPanel }.
	
	RTVerticalLineLayout on: panelElements.
	
	RTNest new
        on: panel nest: panelElements.

	navigationButtons := #().
	^ panel
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> buildMiddlePanelFor: visitCard [
	| panel panelElements pullRequest structureLabel charts chartsPanel |
	pullRequest := visitCard pullRequest.
	panel := RTBox element.

	panelElements := #().
	structureLabel :=	(self label: 'Metrics') element.
	view add: structureLabel.
	
	chartsPanel := (RTBox 
		color: Color transparent) element.
	view add: chartsPanel.

	charts := self buildFileChangesChartFor: pullRequest.
	charts := charts ,	(self buildCodeChangesFor: pullRequest).
	charts := charts select: #isNotNil.
	useStackBarPlot ifTrue: [ 
		RTVerticalLineLayout on: charts.
	] ifFalse: [ 
		RTGridLayout on: charts.
	].
	
	RTNest new
        on: chartsPanel nestRootOf: charts.

	panelElements := panelElements , {
		structureLabel .
		chartsPanel
	}.
	
	self addNavigation: 'Code Changes' view: codeAnalyzer codeChangesViewBlock priority: -9.
	RTVerticalLineLayout on: panelElements.
	
	RTNest new
        on: panel nest: panelElements.
	^ panel
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> buildUpperPanelFor: visitCard [
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
]

{ #category : #accessing }
ThVisCardBuilder >> codeAnalyzer: aCodeAnalyzer [
	codeAnalyzer := aCodeAnalyzer.
	codeAnalyzer
		view: view;
		palette: self palette;
		cardBuilder: self.
	^ aCodeAnalyzer
]

{ #category : #initialization }
ThVisCardBuilder >> grid [
	RTGridLayout on: visitCards
]

{ #category : #'gt inspect' }
ThVisCardBuilder >> gtInspectorCodeChangesViewIn: composite [
	<gtInspectorPresentationOrder: -8>
	codeAnalyzer ifNil: [ ^ self ].
	^ codeAnalyzer gtInspectorCodeChangesViewIn: composite
]

{ #category : #'gt inspect' }
ThVisCardBuilder >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: -7>
	composite text
		title: 'Diff';
		format: [ pullRequests first diff ]
		
]

{ #category : #'gt inspect' }
ThVisCardBuilder >> gtInspectorLegendIn: composite [
	<gtInspectorPresentationOrder: -9>
	composite roassal2
		title: 'Legend';
		initializeView: [ self legend ]
		
]

{ #category : #'gt inspect' }
ThVisCardBuilder >> gtInspectorMainViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Tree View';
		initializeView: view
		
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> guessPullRequestType: pullRequest [
	| title |
	title := pullRequest title.
	(title includesSubstring: 'bug' caseSensitive: false) ifTrue: [ ^ 'Bug Fix' ].
	(title includesSubstring: 'enh' caseSensitive: false) ifTrue: [ ^ 'Enhance' ].
	(title includesSubstring: 'feature' caseSensitive: false) ifTrue: [ ^ 'Feature' ].
	(title includesSubstring: 'dep' caseSensitive: false) ifTrue: [ ^ 'Deprecate' ].
	^ ''
]

{ #category : #initialization }
ThVisCardBuilder >> initialize [
	super initialize.
	view := RTView new.
	view @ RTDraggableView.
	view @ RTZoomableView.
	 
	pullRequests := OrderedCollection new.
	visitCards := OrderedCollection new.
	navigationButtons := #().
	useStackBarPlot := true.
	withoutUnchangedLines := false.
	self nullCodeAnalyzer.
]

{ #category : #accessing }
ThVisCardBuilder >> label: aString [
	^ RTLabel new text: aString; color: self palette textColor; yourself
]

{ #category : #accessing }
ThVisCardBuilder >> label: aString color: aColor [
	^ RTLabel new text: aString; color: aColor; yourself
]

{ #category : #accessing }
ThVisCardBuilder >> legend [
	| legendView |
	legendView := RTView new.
	legendView @ RTDraggableView.
	legendView @ RTZoomableView.
	legendView canvas color: self palette viewBackground.
	self legendForView: legendView.
	^ legendView
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> legendForView: aView [
	| lb |
	lb := RTLegendBuilder new.
	aView ifNotNil: [ lb view: aView ].
	
	lb addText: 'Legend'.
	lb addColor: self palette unchangedColor text: 'Unchanged'.
	lb addColor: self palette additionsColor text: 'Additions'.
	lb addColor: self palette deletionsColor text: 'Deletions'.
	lb addColor: self palette modifiedColor text: 'Modified'.
	lb addColor: self palette movementColor text: 'Moved/Renamed'.
	^ lb build
]

{ #category : #'instance creation' }
ThVisCardBuilder >> newMondrianBuilder [
	| builder |
	builder := RTMondrian new.
	builder view canvas color: self palette viewBackground.
	builder view @ RTDraggableView.
	builder view @ RTZoomableView.
	^ builder
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> nullCodeAnalyzer [
	self codeAnalyzer: ThVisCardNullCodeAnalysisBuilder new
]

{ #category : #accessing }
ThVisCardBuilder >> palette [
	^ palette ifNil: [ ThVisCardColorPalette default ]
]

{ #category : #accessing }
ThVisCardBuilder >> palette: aPalette [
	palette := aPalette
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> pharoCodeAnalyzer [
	^ self codeAnalyzer: ThVisCardPharoCodeAnalysisBuilder new
]

{ #category : #charts }
ThVisCardBuilder >> plotChartMetrics: metrics title: title [
	| panel b ds grapherElements usedMetrics label grapherPanel |
	usedMetrics := metrics select: [:m | m value third ~= 0]
		thenCollect: [ :m | ThVisCardCodeAnalysisBlueprintResumeElement builder: codeAnalyzer value: m].
	usedMetrics ifEmpty: [ ^ nil ].

	panel := RTBox new
		color: self palette metricPlotBackground;
		element.
	view add: panel.

	label := (RTLabel new text: title; color: self palette textColor) element.
	view add: label.

	grapherPanel := RTBox new
		color: Color veryLightGray muchLighter;
		elementOn: (ThVisCardCodeAnalysisBlueprintResumeElement builder: self).	
	view add: grapherPanel.

	b := RTGrapher new.
	b extent: (b extent /2).	
	
	ds := RTData new.
	ds interaction
		highlight;
		popupText: [ :m | m value second format: {m value third asString}].
	ds points: usedMetrics.
	ds barShape
		color: [ :m | m value first ];
		width: 10.
	ds y: [:m | m value third].
	b add: ds.
	b axisY noDecimal; withThousandsSeparator.
	b axisX
		noTick;
		noLabel.

	b build.
	
	grapherElements := b view elements.
	view addAll: grapherElements.
	view addAll: b view edges.
	RTNest new
        on: grapherPanel nestRootOf: grapherElements.

	RTVerticalLineLayout on: { label . grapherPanel }.
	RTNest new
        on: panel nestRootOf: {label . grapherPanel}.
	
	^ panel
]

{ #category : #charts }
ThVisCardBuilder >> plotMetrics: metrics title: title [
	^ useStackBarPlot ifTrue: [self plotStackBarMetrics: metrics title: title] ifFalse: [ self plotChartMetrics: metrics title: title ]
]

{ #category : #charts }
ThVisCardBuilder >> plotStackBarMetrics: metrics title: title [
	| panel usedMetrics label sum height width widthScaleFactor barShape bars barPanel popup metricsSum barLabelPanel barsAndLabels |
	usedMetrics := metrics select: [:m | m isNotNil and: [m value third ~= 0] ]
		thenCollect: [ :m | ThVisCardCodeAnalysisBlueprintResumeElement builder: codeAnalyzer value: m].
	usedMetrics ifEmpty: [ ^ nil ].
	
	sum := 0.
	usedMetrics do: [ :metric | sum := sum + metric value third ].
	
	panel := RTBox new
		color: self palette metricPlotBackground;
		element.
	view add: panel.

	label := (RTLabel new text: title; color: self palette textColor) element.
	view add: label.

	height := 20	.
	width := 300.
	widthScaleFactor := width / sum.

	barLabelPanel := RTBox new
		color: Color white;
		borderColor: Color black;
		element.
	view add: barLabelPanel.
	
	barPanel := RTBox new
		color: Color white;
		borderColor: Color black;
		element.
	view add: barPanel.
	
	barShape := RTBox new
		color: [ :metric | metric value first ];
		width: [:metric | metric value third * widthScaleFactor];
		height: height.
	bars := usedMetrics collect: [ :metric | barShape elementOn: metric ].
	
	metricsSum := 0.
	usedMetrics do: [ :metric | metricsSum := metricsSum + metric value third ].
	view addAll: bars.
	
	popup := RTPopup new text: [ :metric | metric value second format: { metric value third } ].
	popup backgroundColor: self palette popupBackgroundColor.
	bars do: [ :b | b @ popup ].
	
	RTHorizontalLineLayout new gapSize: 0; on: bars.
	
	RTNest new on: barPanel nest: bars.
	
	barsAndLabels := {
		(self label: 0 color: self palette stackBarLabelColor) element.
		barPanel.
		(self label: metricsSum color: self palette stackBarLabelColor) element
	}.
	
	view add: barsAndLabels first; add: barsAndLabels last.
	RTHorizontalLineLayout on: barsAndLabels.
	RTNest new on: barLabelPanel nest: barsAndLabels.

	RTVerticalLineLayout on: {label . barLabelPanel}.
	RTNest new on: panel nest: {label . barLabelPanel}.
	
	^ panel
]

{ #category : #'as yet unclassified' }
ThVisCardBuilder >> pythonCodeAnalyzer [
	^ self codeAnalyzer: ThVisCardPythonCodeAnalysisBuilder new
]

{ #category : #'commit tree view' }
ThVisCardBuilder >> tooltipForCommit: commit [
^ '{1}

Additions: {2}.
Deletions: {3}' format: { commit changeMessage . commit additions asString . commit deletions asString }
]

{ #category : #initialization }
ThVisCardBuilder >> vertical [
	RTVerticalLineLayout on: visitCards
]

{ #category : #accessing }
ThVisCardBuilder >> view [
	^ view
]

{ #category : #accessing }
ThVisCardBuilder >> withoutUnchangedLines [
	withoutUnchangedLines := true
]
