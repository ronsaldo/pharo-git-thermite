Class {
	#name : #ThVisCardPharoCodeAnalysisBuilder,
	#superclass : #ThVisCardCodeAnalysisBlueprintBuilder,
	#instVars : [
		'buildingOldModel'
	],
	#category : 'Thermite-Card-CodeAnalysis-Pharo'
}

{ #category : #'as yet unclassified' }
ThVisCardPharoCodeAnalysisBuilder class >> languageName [
	^ 'Pharo'
]

{ #category : #adding }
ThVisCardPharoCodeAnalysisBuilder >> addClass: class to: parentNode [
	| node |
	node := parentNode childPrefix: 'class ' named: class name ifAbsentPut: [ ThVisPhCardSourceNodeClass new name: class name ].
	node model: class old: buildingOldModel.
	self addMethods: class methods to: node
]

{ #category : #adding }
ThVisCardPharoCodeAnalysisBuilder >> addClasses: classes to: parentNode [
	classes do: [ :class | self addClass: class to: parentNode ]
]

{ #category : #adding }
ThVisCardPharoCodeAnalysisBuilder >> addMethod: method to: parentNode [
	| node |
	node := parentNode childPrefix: 'method ' named: method name ifAbsentPut: [ ThVisPhCardSourceNodeMethod new name: method name ].
	node model: method old: buildingOldModel.
]

{ #category : #adding }
ThVisCardPharoCodeAnalysisBuilder >> addMethods: methods to: parentNode [
	methods do: [ :method | self addMethod: method to: parentNode ]
]

{ #category : #adding }
ThVisCardPharoCodeAnalysisBuilder >> addPackage: package to: parentNode [
	| packageNode |
	packageNode := parentNode childPrefix: 'package ' named: package name ifAbsentPut: [ ThVisPhCardSourceNodePackage new name: package name ].
	packageNode model: package old: buildingOldModel.
	self addClasses: package definedClasses to: packageNode.

]

{ #category : #adding }
ThVisCardPharoCodeAnalysisBuilder >> addPackages: packages to: root [
	packages do: [ :package | self addPackage: package to: root ]
]

{ #category : #visualization }
ThVisCardPharoCodeAnalysisBuilder >> build: b changes: changes [
	| panels packages |
	b interaction popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		withTextAbove: #name;
		borderColor: #changeBorderColor;
		borderWidth: 3;
		color: self palette packageBackground.
	b shape shape allShapes first color: self palette textColor.
	packages := changes children.
	onlyModifiedPackages ifTrue: [ 
		packages := packages reject: [:child | child wasModified not].
	].

	b nodes: packages forEach: [ :package |
		b interaction
			noInteractions;
			popupText: [:p | p node description] solidBackgroundColor: self palette popupBackgroundColor.

		b shape rectangle
			withTextAbove: #title;
			borderColor: Color transparent;
			color: self palette filesBackground.
		b shape shape allShapes first color: self palette packagePanelTitleColor.

		panels := { ThVisCardSourceNodeSubElementBuildProxy new node: package; action: [self addLinesChangedChartOf: package visualizationWith: b]; title: 'Lines' }.
		package hasChildren ifTrue: [ 
			panels := panels , {ThVisCardSourceNodeSubElementBuildProxy new node: package; action: [self buildPackageContent: package visualizationWith: b]; title: 'Content'}
		].

		b nodes: panels forEach: [ :el |
			el action value
		].
	
		b layout horizontalLine.
	].

	b layout grid.
]

{ #category : #visualization }
ThVisCardPharoCodeAnalysisBuilder >> buildCodeChangesDetails [
	| b |
	b := self newMondrianBuilder.
	b interaction noInteractions.
	
	self build: b changes: sourceRootNode.
	b layout grid.
	
	self buildSimilaryEdgesOn: b.
	b build.
	^ b
]

{ #category : #'as yet unclassified' }
ThVisCardPharoCodeAnalysisBuilder >> computeCodeChangesFor: pullRequest [
	| versions oldVersion newVersion |
	versions := pullRequest loadOldAndNewMonticelloPackages.
	oldVersion := versions first.
	newVersion := versions second.
	
	sourceRootNode := self computeCodeChangesFor: pullRequest oldVersion: oldVersion newProcessor: newVersion.
	self computeSimilaritiesForChanges: sourceRootNode.

]

{ #category : #'as yet unclassified' }
ThVisCardPharoCodeAnalysisBuilder >> computeCodeChangesFor: pullRequest oldVersion: oldVersion newProcessor: newVersion [
	| root |
	root := ThVisCardSourceNodeRoot new.
	buildingOldModel := true.
	self addPackages: oldVersion to: root.
	buildingOldModel := false.
	self addPackages: newVersion to: root.
	^ root
]

{ #category : #'as yet unclassified' }
ThVisCardPharoCodeAnalysisBuilder >> filterModifiedFiles: files [
	^ files reject: [ :file | (file filename includesSubstring: '.package') or:
		[ (file basename endsWith: '.class.st') or:
		[ (file basename endsWith: '.extension.st') or:
		[ file basename = 'package.st' ] ]]]
]

{ #category : #initialization }
ThVisCardPharoCodeAnalysisBuilder >> initialize [
	super initialize.
	self onlyModifiedClasses
]
