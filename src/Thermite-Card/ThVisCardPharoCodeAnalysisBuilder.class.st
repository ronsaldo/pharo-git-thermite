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
	| panels |
	b interaction popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		withTextAbove: #name;
		borderColor: #changeBorderColor;
		borderWidth: 3;
		color: self palette packageBackground.
	b shape shape allShapes first color: self palette textColor.
	b nodes: changes children forEach: [ :package |
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
	^ files reject: [ :file | file filename includesSubstring: '.package' ]
]

{ #category : #'as yet unclassified' }
ThVisCardPharoCodeAnalysisBuilder >> findModifiedPackagesIn: pullRequest [
	| re range filetreeRepository packageName result ranges |
	re := '[^/\\]+\.package' asRegex.
	result := Dictionary new.
	pullRequest modifiedFilenames do: [ :filename |
		ranges := (re matchingRangesIn: filename).
		ranges ifNotEmpty: [
			range := ranges last.
			filetreeRepository := filename first: range first - 1.
			packageName := filename copyFrom: range first to: range last.
			result at: filetreeRepository , packageName put: { packageName . filetreeRepository } 
		]
	].
	^ result

]

{ #category : #initialization }
ThVisCardPharoCodeAnalysisBuilder >> initialize [
	super initialize.
	self onlyModifiedClasses
]

{ #category : #'as yet unclassified' }
ThVisCardPharoCodeAnalysisBuilder >> loadPackages: packages pullRequest: pullRequest [
	| packageName filetreeRepository filetreeReference repository version package elements methodClass |
	^ packages values collect: [ :value |
		packageName := value first.
		filetreeRepository := value second ifEmpty: ['.'].
		filetreeReference := pullRequest repository clonePath asFileReference resolve: filetreeRepository.
		filetreeReference exists ifTrue: [ 
			repository := MCFileTreeRepository new directory: filetreeReference.

			version := repository versionFrom: (repository versionNameFromFileName: packageName).
			version ifNotNil: [ 
				package := RGPackage named: packageName.
				elements := version snapshot definitions collect: #asRingDefinition.
				elements reject: #isOrganization thenDo: [ :element |
					(element isTrait and: [ element isMeta ]) ifFalse: [ 
						package addElement: element
					]
				].
				package methodsDo: [ :method |
					methodClass := package lookupClassNamed: method className.
					methodClass ifNotNil: [ methodClass addMethod: method ]
				].
				package
			]
		]
	] thenSelect: #isNotNil
]
