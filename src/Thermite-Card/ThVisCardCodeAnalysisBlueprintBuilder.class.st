Class {
	#name : #ThVisCardCodeAnalysisBlueprintBuilder,
	#superclass : #ThVisCardCodeAnalysisBuilder,
	#instVars : [
		'onlyModifiedContent',
		'onlyModifiedClasses',
		'onlyModifiedFunctions',
		'sourceRootNode',
		'similarityGroups',
		'withoutUnchangedLines'
	],
	#classVars : [
		'NodeChartHeight',
		'NodeChartWidth'
	],
	#category : 'Thermite-Card-CodeAnalysis'
}

{ #category : #initialization }
ThVisCardCodeAnalysisBlueprintBuilder class >> initialize [
	NodeChartHeight := 25.0.
	NodeChartWidth := NodeChartHeight *0.50.
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBlueprintBuilder class >> languageName [
	self subclassResponsibility
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> addLinesChangedChartOf: node visualizationWith: b [
	| displayedLinesSum nodeSize normalizationFactor |
	b interaction
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		borderColor: self palette normalNodeBorderColor;
		borderWidth: 3;
		color: #changeColor.

	displayedLinesSum := node additions + node deletions.
	withoutUnchangedLines ifFalse: [ 
		displayedLinesSum := displayedLinesSum + node unchangedNumberOfLines
	].
	
	nodeSize := displayedLinesSum sqrt * 0.25.
	normalizationFactor := nodeSize * NodeChartHeight / (displayedLinesSum max: 1.0).
	b shape box
		color: [:proxy | proxy metric second];
		width: NodeChartWidth;
		height: [:proxy | proxy metric third].
	b interaction
		noInteractions;
		popupText: [:el | node description ]
		solidBackgroundColor: self palette popupBackgroundColor.
	node hasMovementRefactor ifTrue: [ 
		b nodes: ({
			node proxyForMetric: {displayedLinesSum asString , ' moved lines' . self palette movementColor . node unchangedNumberOfLines*normalizationFactor}.
			}).
		] ifFalse: [ 
			b nodes: ({
				withoutUnchangedLines ifFalse: [
					node proxyForMetric: {node unchangedNumberOfLines asString , ' unchanged lines' . self palette leafUnchangedColor . node unchangedNumberOfLines*normalizationFactor}
				].
			node proxyForMetric: {node additions asString , ' additions' . self palette additionsColor . node additions* normalizationFactor}.
			node proxyForMetric: {node deletions asString , ' deletions' . self palette deletionsColor . node deletions*normalizationFactor}
		} select: [:el | el isNotNil and: [el metric third ~= 0] ]).
	].
	b layout verticalLine verticalGap: 0.
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintBuilder >> allContent [
	withoutUnchangedLines := false.
	onlyModifiedClasses := false.
	onlyModifiedFunctions := false.
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildClassContent: class visualizationWith: builder [
	| children |
	children := class children.
	onlyModifiedFunctions ifTrue: [
		children := children reject: [:child | child isFunction and: [child wasModified not or: [ child shouldBeFiltered ]]].
	].

	children := children sorted: [:a :b | a name < b name ].
	self buildLeafTextNodes: children visualizationWith: builder.
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildClasses: nodes visualizationWith: b [
	| classes classDictionary |
	b interaction 
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		withTextBelow: #name;
		borderColor: #changeBorderColor;
		borderWidth: 3;
		color: [:n | n hasMovementRefactor
				ifTrue: [self palette classMovementRefactorInteriorColor ]
				ifFalse: [self palette classInteriorColor]].
	b shape shape allShapes second color: [ self palette textColor ].
	classes := nodes select: #isClass.

	b nodes: classes forEach: [:class |
		self buildClassContent: class visualizationWith: b
	].

	classDictionary := Dictionary new.
	classes do: [ :cls | classDictionary at: cls name put: cls ].

	b shape orthoVerticalLine color: self palette deletionsColor.
	b edges
		connectFrom: [ :cls | cls unchangedSuperName ifNil: [classDictionary at: cls oldSuperName ifAbsent: [ nil ] ] ifNotNil: [ nil ] ].

	b shape orthoVerticalLine color: self palette classHierarchyUnchangedColor.
	b edges
		connectFrom: [ :cls | classDictionary at: cls unchangedSuperName ifAbsent: [ nil ] ].

	b shape orthoVerticalLine color: self palette additionsColor.
	b edges
		connectFrom: [ :cls | cls unchangedSuperName ifNil: [classDictionary at: cls newSuperName ifAbsent: [ nil ] ] ifNotNil: [ nil ] ].

]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildClassesOf: root visualizationWith: b [
	| children |
	children := root children select: #isClass.
	onlyModifiedClasses ifTrue: [ 
		children := children reject: [:child | child wasModified not].
	].

	self buildClasses: children visualizationWith: b

]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildCodeChangesDetails [
	^ self newMondrianBuilder
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildCodeChangesFor: pullRequest [
	self computeCodeChangesFor: pullRequest.
	sourceRootNode withAllChildrenDo: [ :node | node palette: self palette ].

	^ {
		self linesOfCodeChart .
		self classesMetricsChart.
		self methodsMetricsChart.
	} select: #isNotNil
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildFileContent: file visualizationWith: b [
	self buildClassesOf: file visualizationWith: b.
	self buildFunctionsOf: file visualizationWith: b.
	b layout tree;
		ifNotConnectedThen: RTGridLayout new.
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildFiles: files visualizationWith: b [
	| panels |
	b interaction
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		withTextAbove: #name;
		borderColor: #changeBorderColor;
		borderWidth: 3;
		color: self palette filesBackground.
	b shape shape allShapes first color: self palette textColor.
	b nodes: files forEach: [ :file |
		b interaction
			noInteractions;
			popupText: [:p | p node description] solidBackgroundColor: self palette popupBackgroundColor.

		b shape rectangle
			withTextAbove: #title;
			borderColor: Color transparent;
			color: self palette filesBackground.
		b shape shape allShapes first color: self palette packagePanelTitleColor.

		panels := { ThVisCardSourceNodeSubElementBuildProxy new node: file; action: [self addLinesChangedChartOf: file visualizationWith: b]; title: 'Lines' }.
		file hasChildren ifTrue: [ 
			panels := panels , {ThVisCardSourceNodeSubElementBuildProxy new node: file; action: [self buildFileContent: file visualizationWith: b]; title: 'Content'}
		].
	
		b nodes: panels forEach: [ :el |
			el action value
		].
	
		b layout horizontalLine.
	].
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildFunctions: aListOfFunctions visualizationWith: b [
	self buildLeafTextNodes: aListOfFunctions visualizationWith: b displayNames: true
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildFunctionsOf: root visualizationWith: b [
	| children |
	children := root children.
	onlyModifiedFunctions ifTrue: [ 
		children := children reject: [:child | child isFunction and: [child wasModified not]].
	].
	self buildFunctions: (children select: #isFunction) visualizationWith: b
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildLeafTextNodes: leafNodes visualizationWith: b [
	self buildLeafTextNodes: leafNodes visualizationWith: b displayNames: false
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildLeafTextNodes: leafNodes visualizationWith: b displayNames: displayNames [
	| displayedLinesSum nodeSize normalizationFactor |
	
	b interaction
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle.
	displayNames ifTrue: [
		b shape withTextAbove: #name
	].
	b shape
		borderColor: self palette normalNodeBorderColor;
		borderWidth: 3;
		color: #changeColor.
	displayNames ifTrue: [
		b shape shape allShapes first color: self palette textColor.
	].

	b nodes: leafNodes forEach: [ :node |
		displayedLinesSum := node additions + node deletions.
		withoutUnchangedLines ifFalse: [ 
			displayedLinesSum := displayedLinesSum + node unchangedNumberOfLines
		].
	
		nodeSize := displayedLinesSum sqrt * 0.25.
		normalizationFactor := nodeSize * NodeChartHeight / displayedLinesSum.
		b shape box
			color: [:proxy | proxy metric second];
			width: NodeChartWidth;
			height: [:proxy | proxy metric third].
		b interaction
			noInteractions;
			popupText: [:el | node description ] solidBackgroundColor: self palette popupBackgroundColor.
		node hasMovementRefactor ifTrue: [ 
			b nodes: ({
				node proxyForMetric: {displayedLinesSum asString , ' moved lines' . self palette movementColor . node unchangedNumberOfLines*normalizationFactor}.
			}).
		] ifFalse: [ 
			b nodes: ({
				withoutUnchangedLines ifFalse: [
					node proxyForMetric: {node unchangedNumberOfLines asString , ' unchanged lines' . self palette leafUnchangedColor . node unchangedNumberOfLines*normalizationFactor}
				].
				node proxyForMetric: {node additions asString , ' additions' . self palette additionsColor . node additions* normalizationFactor}.
				node proxyForMetric: {node deletions asString , ' deletions' . self palette deletionsColor . node deletions*normalizationFactor}
			} select: [:el | el isNotNil and: [el metric third ~= 0] ]).
		].
		b layout verticalLine verticalGap: 0.
	].

	b layout grid.
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildPackageContent: package visualizationWith: b [
	self buildClassesOf: package visualizationWith: b.
	b layout tree;
		ifNotConnectedThen: RTGridLayout new.
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> buildSimilaryEdgesOn: builder [
	| elements edges |
	similarityGroups do: [ :g |
		elements := builder view elementsFromModels: g.
		builder edges shape color: Color transparent.
		edges := builder edges
			elements: elements;
			useAssociations: (g allButFirst collect: [:t | g first -> t]).
		self displayEdges: edges forElements: elements
	]

]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> classesMetricsChart [
	| addedClasses removedClasses movedClasses modifiedClasses unchangedClasses counted allClasses |
	allClasses := OrderedCollection new.
	addedClasses := OrderedCollection new.
	removedClasses := OrderedCollection new.
	movedClasses := OrderedCollection new.
	modifiedClasses := OrderedCollection new.
	unchangedClasses := OrderedCollection new.
	
	sourceRootNode allChildrenDo: [ :node |
		node isClass ifTrue: [
			counted := false.
			node hasMovementRefactor ifTrue: [
				counted := true.
				movedClasses add: node
			] ifFalse: [
				node wasAdded ifTrue: [ addedClasses add: node. counted := true ].
				node wasRemoved ifTrue: [ removedClasses add: node. counted := true ].
				node wasInternallyModified ifTrue: [ modifiedClasses add: node. counted := true ].
				counted ifFalse: [
					onlyModifiedClasses ifFalse: [ 
						unchangedClasses add: node
					]
				]
			].
		
			(onlyModifiedClasses not or: [counted ]) ifTrue: [ allClasses add: node ]
		].
	].

	allClasses ifNotEmpty: [ 
		cardBuilder addNavigation: 'Classes' view: (self visualizationForClasses: allClasses)
	].

	^ self plotMetrics: {
		{ self palette additionsColor . '{1} - Added classes' . addedClasses size . self visualizationForClasses: addedClasses }.
		{ self palette deletionsColor . '{1} - Removed classes' . removedClasses size . self visualizationForClasses: removedClasses }.
		{ self palette movementColor . '{1} - Moved classes' . movedClasses size . self visualizationForClasses: movedClasses }.
		{ self palette modifiedColor . '{1} - Modified classes' . modifiedClasses size . self visualizationForClasses: modifiedClasses }.
		{ self palette unchangedColor . '{1} - Unchanged classes ' . unchangedClasses size . self visualizationForClasses: unchangedClasses }
	} title: 'Classes'.
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBlueprintBuilder >> codeChangesView [
	^ self buildCodeChangesDetails
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBlueprintBuilder >> codeChangesViewBlock [
	^ [ self codeChangesView ]
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBlueprintBuilder >> computeCodeChangesFor: pullRequest [
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBlueprintBuilder >> computeSimilaritiesForChanges: changes [
	self computeSimilaritiesForMethodChanges: changes.
	self computeSimilaritiesForClassChanges: changes.
	self computeSimilaritiesGroupsFor: changes.
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBlueprintBuilder >> computeSimilaritiesForClassChanges: changes [
	| targetClasses maxTargetClass maxTargetMoveCount movedPercentage |
	changes allChildrenDo: [ :n |
		(n hasMovementRefactor not and: [n isClass and: [n wasAdded or: [n wasRemoved ]]]) ifTrue: [
			targetClasses := IdentityDictionary new.
			n children do: [ :c |
				c hasMovementRefactor ifTrue: [
					c movementRefactorNodesDo: [ :mv |
						(mv parent isClass and: [(n wasAdded and: [ mv wasRemoved ]) or: [ n wasRemoved and: [ mv wasAdded ]]]) ifTrue: [
							targetClasses at: mv parent put: (targetClasses at: mv parent ifAbsent: [0]) + 1
						]
					]
				]
			].
		
			maxTargetClass := nil.
			maxTargetMoveCount := 0.
			targetClasses keysAndValuesDo: [ :class :moveCount |
				moveCount > maxTargetMoveCount ifTrue: [
					maxTargetMoveCount := moveCount.
					maxTargetClass := class
				] 
			].	
		
			movedPercentage := maxTargetMoveCount / (n children size asFloat max: 1).
			movedPercentage > 0.6 ifTrue: [ 
				n hasMovementRefactor: true.
				n connectMovementRefactorWith: maxTargetClass
			]
		]
	]
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBlueprintBuilder >> computeSimilaritiesForMethodChanges: changes [
	| removedNodes addedNodes nodesWithHashes previousElement |
	
	removedNodes := OrderedCollection new.
	addedNodes := OrderedCollection new.
	changes allChildrenDo: [ :n |
		n shouldBeTestedForCodeSimilarity ifTrue: [ 
			n wasRemoved ifTrue: [
				removedNodes add: n
			].
			
			n wasAdded ifTrue: [
				addedNodes add: n
			].
		]
	].

	"Check for equality with the help of hashing"
	nodesWithHashes := (removedNodes collect: [ :n | { n oldSource hash . n oldSource . n} ]) ,
		(addedNodes collect: [ :n | { n newSource hash . n newSource. n} ]).
	nodesWithHashes sort: [ :a :b |
		a first = b first ifTrue: [
			a second <= b second
		] ifFalse: [ 
			a first <= b first
		]
	].

	previousElement := nil.
	nodesWithHashes do: [ :element |
		(previousElement isNotNil and: [ previousElement second = element second ]) ifTrue: [
			previousElement third
				hasMovementRefactor: true;
				nextMovementRefactorNode: element third.
				
			element third
				hasMovementRefactor: true;
				previousMovementRefactorNode: previousElement third.
			
		].
		previousElement := element.
	].

	"Build the bag of words"
	"emptyBow := GThCodeBagOfWords empty.
	bowBuilder := GThCodeBagOfWordsBuilder new.
	removedNodes do: [ :n |
		n
			oldSourceBagOfWords: (bowBuilder forString: n oldSource);
			newSourceBagOfWords: emptyBow
	].

	addedNodes do: [ :n |
		n
			oldSourceBagOfWords: emptyBow;
			newSourceBagOfWords: (bowBuilder forString: n newSource)
	]."

	"
	GThCodeBagOfWords matrixForSimilaritiesOf: (nodes collect: #sourceBagOfWords).
	GThCodeBagOfWords formForSimilaritiesOf: (nodes collect: #sourceBagOfWords).
	GThCodeBagOfWords formForSimilaritiesOf: (nodes collect: #sourceBagOfWords) threshold: 0.8.
	"
]

{ #category : #'as yet unclassified' }
ThVisCardCodeAnalysisBlueprintBuilder >> computeSimilaritiesGroupsFor: changes [
	| procesedElements alreadyProcessed group |
	procesedElements := IdentitySet new.
	similarityGroups := OrderedCollection new.
	
	changes allChildrenDo: [ :node |
		node isFalseMovementPositive ifTrue: [
			node hasMovementRefactor: false
		] ifFalse: [ 
		(node hasMovementRefactor and: [ node shouldBeCountedAsMovement ]) ifTrue: [

			alreadyProcessed := false.
			group := Array streamContents: [ :out |
				node allMovementRefactorNodesDo: [ :sn |
					(procesedElements includes: sn) ifTrue: [
						alreadyProcessed := true.
					].
				
					alreadyProcessed ifFalse: [ 
						out nextPut: sn.
						procesedElements add: sn
					].
				]
			].
		
			alreadyProcessed ifFalse: [
				similarityGroups add: group
			]
		]]
	]

]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> displayEdges: edges forElements: elements [
	elements do: [ :element |
		element
			when: TRMouseEnter
			do: [ :e |
				edges do: [ :edge | edge color: self palette movementColor ].
				e signalUpdate ].
		element
			when: TRMouseLeave
			do: [ :e | 
				edges do: [ :edge | edge color: Color transparent ].
				e signalUpdate
			]
	]
]

{ #category : #'gt inspect' }
ThVisCardCodeAnalysisBlueprintBuilder >> gtInspectorCodeChangesViewIn: composite [
	<gtInspectorPresentationOrder: -9>
	composite roassal2
		title: 'All Code Changes';
		initializeView: [ self buildCodeChangesDetails ]

]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintBuilder >> initialize [
	super initialize.
	self allContent;
		onlyModifiedFunctions.
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> linesOfCodeChart [
	| unchangedLoc addedLoc removedLoc |
	unchangedLoc := 0.
	addedLoc := 0.
	removedLoc := 0.
	sourceRootNode children do: [ :node |
		unchangedLoc := unchangedLoc + node unchangedNumberOfLines.
		addedLoc := addedLoc + node additions.
		removedLoc := removedLoc + node deletions.
	].

	^ self plotMetrics: {
		{ self palette additionsColor . '{1} - Added lines of code' . addedLoc }.
		{ self palette deletionsColor . '{1} - Removed lines of code' . removedLoc }.
		withoutUnchangedLines ifFalse: [ { self palette unchangedColor . '{1} - Unchanged lines of code' . unchangedLoc }].
	} title: 'Lines of Code'.
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> methodsMetricsChart [
	|  addedMethods removedMethods movedMethods modifiedMethods unchangedMethods counted allMethods |
	addedMethods := OrderedCollection new.
	removedMethods := OrderedCollection new.
	modifiedMethods := OrderedCollection new.
	movedMethods := OrderedCollection new.
	unchangedMethods := OrderedCollection new.
	allMethods := OrderedCollection new.
	sourceRootNode allChildrenDo: [ :node |
		self flag: 'TODO: Check this filtering'.
		node isFunction ifTrue: [
			counted := false.
			node hasMovementRefactor ifTrue: [
				counted := true.
				node shouldBeCountedAsMovement ifTrue: [
					movedMethods add: node.
				]
			] ifFalse: [ 
				node wasAdded ifTrue: [ addedMethods add: node . counted := true ].
				node wasRemoved ifTrue: [ removedMethods add: node . counted := true ].
			].
			node wasInternallyModified ifTrue: [ modifiedMethods add: node . counted := true ].
			
			counted ifFalse: [
				onlyModifiedFunctions ifFalse: [
					unchangedMethods add: node
				]
			].
		
			(onlyModifiedFunctions not or: [ counted ]) ifTrue: [ allMethods add: node ]
		].
	].

	allMethods ifNotEmpty: [ 
		cardBuilder addNavigation: 'Methods' view: (self visualizationForMethods: allMethods)
	].

	^ self plotMetrics: {
		{ self palette additionsColor . '{1} - Added methods/functions' . addedMethods size . self visualizationForMethods: addedMethods }.
		{ self palette deletionsColor . '{1} - Removed methods/functions' . removedMethods size . self visualizationForMethods: removedMethods }.
		{ self palette movementColor . '{1} - Moved methods/functions' . movedMethods size . self visualizationForMethods: movedMethods }.
		{ self palette modifiedColor . '{1} - Modified methods/functions' . modifiedMethods size . self visualizationForMethods: modifiedMethods }.
		{ self palette unchangedColor . '{1} - Unchanged methods/functions' . unchangedMethods size . self visualizationForMethods: unchangedMethods }.
	} title: 'Methods/Functions'.
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintBuilder >> onlyModifiedClasses [
	onlyModifiedClasses := true
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintBuilder >> onlyModifiedContent [
	onlyModifiedContent := true
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintBuilder >> onlyModifiedFunctions [
	onlyModifiedFunctions := true
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> visualizationForClasses: aCollectionOfClasses [
	| builder |
	^ [
		builder := self newMondrianBuilder.
		self buildClasses: (aCollectionOfClasses sorted: [:a :b | a name < b name ]) visualizationWith: builder.
		builder layout tree;
		ifNotConnectedThen: RTGridLayout new.
		builder
	]
]

{ #category : #visualization }
ThVisCardCodeAnalysisBlueprintBuilder >> visualizationForMethods: aCollectionOfMethods [
	| builder |
	^ [
		builder := self newMondrianBuilder.
		self buildLeafTextNodes: (aCollectionOfMethods sorted: [ :a :b | a name < b name ]) visualizationWith: builder displayNames: true.
		builder
	]
]

{ #category : #accessing }
ThVisCardCodeAnalysisBlueprintBuilder >> withoutUnchangedLines [
	withoutUnchangedLines := true
]
