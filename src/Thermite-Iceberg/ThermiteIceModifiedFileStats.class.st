Class {
	#name : #ThermiteIceModifiedFileStats,
	#superclass : #Object,
	#instVars : [
		'sourceCommitModel',
		'targetCommitModel',
		'path',
		'diff',
		'oldContent',
		'newContent',
		'newVersionLineCount',
		'oldVersionLineCount',
		'additions',
		'deletions'
	],
	#category : #'Thermite-Iceberg'
}

{ #category : #accessing }
ThermiteIceModifiedFileStats >> additions [
	additions ifNil: [ self computeDiffStats ].
	^ additions
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> computeDiffStats [
	| diffBuilder |
	diffBuilder := TextDiffBuilder from: self oldContent to: self newContent.
	additions := 0.
	deletions := 0.
	diffBuilder patchSequenceDoIfMatch: [ :string | ]
		ifInsert: [ :string | additions := additions + 1]
		ifRemove: [ :string | deletions := deletions + 1]

]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> countLines: aString [
	"Method taken from CompiledMethod >>linesOfCode."
	
	"An approximate measure of lines of code.
	Includes comments, but excludes empty lines."
	| lines |
	lines := 0.
	aString lineIndicesDo: [:start :endWithoutDelimiters :end |
		endWithoutDelimiters > start ifTrue: [lines := lines+1]].
	^ lines
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> deletions [
	deletions ifNil: [ self computeDiffStats ].
	^ deletions
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> diff [
	^ diff ifNil: [diff := (TextDiffBuilder from: self oldContent to: self newContent) buildDisplayPatch]
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> filename [
	^ path fullName
]

{ #category : #ui }
ThermiteIceModifiedFileStats >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: 1>
	composite text
		title: 'Diff';
		format: [ self diff ]
		
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> newContent [
	^ newContent ifNil: [ newContent := self newContentFileReference exists
			ifTrue: [self newContentFileReference contents ]
			ifFalse: [ '' ]]
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> newContentFileReference [
	^ targetCommitModel entity fileSystem resolve: path.
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> newVersionLineCount [
	^ newVersionLineCount ifNil: [ newVersionLineCount := self countLines: self newContent ]
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> oldContent [
	^ oldContent ifNil: [ oldContent := self oldContentFileReference exists
			ifTrue: [self oldContentFileReference contents]
			ifFalse: [ '' ] ]
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> oldContentFileReference [
	^ sourceCommitModel entity fileSystem resolve: path.
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> oldVersionLineCount [
	^ oldVersionLineCount ifNil: [ oldVersionLineCount := self countLines: self oldContent ]
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> path [
	^ path
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> path: anObject [
	path := anObject
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> printOn: aStream [
	^ aStream nextPutAll: self filename; nextPutAll: ' Additions: '; print: self additions; nextPutAll: ' Deletions: '; print: self deletions
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> sourceCommitModel [
	^ sourceCommitModel
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> sourceCommitModel: anObject [
	sourceCommitModel := anObject
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> targetCommitModel [
	^ targetCommitModel
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> targetCommitModel: anObject [
	targetCommitModel := anObject
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> wasAdded [
	^ self oldContentFileReference exists not
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> wasModified [
	^ self additions ~= 0 or: [ self deletions ~= 0 ]
]

{ #category : #accessing }
ThermiteIceModifiedFileStats >> wasRemoved [
	^ self newContentFileReference exists not
]
