Class {
	#name : #ThVisPyMemoryFile,
	#superclass : #PyFile,
	#instVars : [
		'sourceCode'
	],
	#category : #'Thermite-Card-CodeAnalysis-Python'
}

{ #category : #accessing }
ThVisPyMemoryFile >> getSource [
	^ sourceCode 
]

{ #category : #accessing }
ThVisPyMemoryFile >> initializeFromContentAsString: string [
	sourceCode := string.
	^ super initializeFromContentAsString: string
]
