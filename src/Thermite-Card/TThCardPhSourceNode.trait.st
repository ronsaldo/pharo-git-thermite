Trait {
	#name : #TThCardPhSourceNode,
	#category : 'Thermite-Card-CodeAnalysis-Pharo'
}

{ #category : #'instance creation' }
TThCardPhSourceNode >> countLines: string [
	"Method taken from CompiledMethod >>linesOfCode."
	
	"An approximate measure of lines of code.
	Includes comments, but excludes empty lines."
	| lines |
	lines := 0.
	string lineIndicesDo: [:start :endWithoutDelimiters :end |
		endWithoutDelimiters > start ifTrue: [lines := lines+1]].
	^ lines
]

{ #category : #'instance creation' }
TThCardPhSourceNode >> newLoc [
	^ self countLines: self newSource
]

{ #category : #'instance creation' }
TThCardPhSourceNode >> newSource [
	^ self newModel ifNil: [ '' ] ifNotNil: [ :model |
		model isMethod ifTrue: [ model sourceCode ] ifFalse: [ '' ]
	]
]

{ #category : #'instance creation' }
TThCardPhSourceNode >> oldLoc [
	^ self countLines: self oldSource
]

{ #category : #'instance creation' }
TThCardPhSourceNode >> oldSource [
	^ self oldModel ifNil: [ '' ] ifNotNil: [ :model |
		model isMethod ifTrue: [ model sourceCode ] ifFalse: [ '' ]
	]
]
