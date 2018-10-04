Class {
	#name : #ThVisCardPythonCodeAnalysisBuilder,
	#superclass : #ThVisCardCodeAnalysisBlueprintBuilder,
	#instVars : [
		'buildingOldModel'
	],
	#category : 'Thermite-Card-CodeAnalysis-Python'
}

{ #category : #'as yet unclassified' }
ThVisCardPythonCodeAnalysisBuilder class >> languageName [
	^ 'Python'
]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> addClass: class to: parentNode [
	| node |
	node := parentNode childPrefix: 'class ' named: class name ifAbsentPut: [ ThVisPyCardSourceNodeClass new name: class name ].
	node model: class old: buildingOldModel.
	self addMethods: class methods to: node
]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> addClasses: classes to: parentNode [
	classes do: [ :class | self addClass: class to: parentNode ]
]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> addFile: file to: parentNode [
	| fileNode |
	fileNode := parentNode childPrefix: 'file ' named: file filename ifAbsentPut: [ ThVisPyCardSourceNodeFile new name: file filename ].
	fileNode model: file old: buildingOldModel.
	
	self
		addClasses: file classes to: fileNode;
		addFunctions: file functions to: fileNode
]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> addFiles: files to: root [
	files do: [ :file | self addFile: file to: root ]
]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> addFunction: function to: parentNode [
	| node |
	node := parentNode childPrefix: 'method ' named: function name ifAbsentPut: [ ThVisPyCardSourceNodeFunction new name: function name ].
	node model: function old: buildingOldModel.

]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> addFunctions: functions to: parentNode [
	functions do: [ :function | self addFunction: function to: parentNode ]
]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> addMethod: method to: parentNode [
	| node |
	node := parentNode childPrefix: 'method ' named: method name ifAbsentPut: [ ThVisPyCardSourceNodeFunction new name: method name ].
	node model: method old: buildingOldModel.
]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> addMethods: methods to: parentNode [
	methods do: [ :method | self addMethod: method to: parentNode ]
]

{ #category : #'as yet unclassified' }
ThVisCardPythonCodeAnalysisBuilder >> buildCodeChangesDetails [
	| b |
	b := self newMondrianBuilder.
	b interaction noInteractions.
	
	self buildFiles: sourceRootNode children visualizationWith: b.
	b layout grid.
	
	b build.
	^ b
]

{ #category : #'as yet unclassified' }
ThVisCardPythonCodeAnalysisBuilder >> computeCodeChangesFor: pullRequest [
	| modifications oldProcessor newProcessor |
	modifications := pullRequest modifications.
	oldProcessor := PyProcessor new.
	newProcessor := PyProcessor new.

	pullRequest modifications do: [ :modification |
		modification oldContent ifNotNil: [ 
			oldProcessor processMemoryFileAsString: modification oldContent named: modification filename.
		].
		modification newContent ifNotNil: [ 
			newProcessor processMemoryFileAsString: modification newContent named: modification filename.
		]
	].
	
	^ self computeCodeChangesFor: pullRequest oldProcessor: oldProcessor newProcessor: newProcessor

]

{ #category : #'as yet unclassified' }
ThVisCardPythonCodeAnalysisBuilder >> computeCodeChangesFor: pullRequest oldProcessor: oldProcessor newProcessor: newProcessor [
	sourceRootNode := ThVisCardSourceNodeRoot new.
	buildingOldModel := true.
	self addFiles: oldProcessor files to: sourceRootNode.
	buildingOldModel := false.
	self addFiles: newProcessor files to: sourceRootNode.
	self computeSimilaritiesForChanges: sourceRootNode.
]

{ #category : #'structure diff' }
ThVisCardPythonCodeAnalysisBuilder >> doBuildCodeChangesFor: pullRequest oldProcessor: oldProcessor newProcessor: newProcessor builder: b [
	| root |
	root := ThVisCardSourceNodeRoot new.
	buildingOldModel := true.
	self addFiles: oldProcessor files to: root.
	buildingOldModel := false.
	self addFiles: newProcessor files to: root.

	self buildFiles: root children visualizationWith: b.
	b layout grid
]
