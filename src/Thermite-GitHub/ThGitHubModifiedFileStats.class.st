Class {
	#name : #ThGitHubModifiedFileStats,
	#superclass : #Object,
	#instVars : [
		'filename',
		'additions',
		'deletions',
		'repository',
		'oldVersionBranchName',
		'newVersionBranchName',
		'oldContent',
		'newContent',
		'diff',
		'oldVersionLineCount',
		'newVersionLineCount'
	],
	#category : #'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubModifiedFileStats >> additions [
	^ additions
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> additions: anObject [
	additions := anObject
]

{ #category : #ui }
ThGitHubModifiedFileStats >> countLines: aString [
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
ThGitHubModifiedFileStats >> deletions [
	^ deletions
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> deletions: anObject [
	deletions := anObject
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> diff [
	^ diff ifNil: [diff := (TextDiffBuilder from: self oldContent to: self newContent) buildDisplayPatch]
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> filename [
	^ filename
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> filename: anObject [
	filename := anObject
]

{ #category : #ui }
ThGitHubModifiedFileStats >> gtInspectorDiffIn: composite [
	<gtInspectorPresentationOrder: 1>
	composite text
		title: 'Diff';
		format: [ self diff ]
		
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> newContent [
	^ newContent ifNil: [ repository executeGitCommandOutput: self newContentCommand ]
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> newContentCommand [
	^ 'git show ' , newVersionBranchName , ':' , filename
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> newVersionBranchName [
	^ newVersionBranchName
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> newVersionBranchName: anObject [
	newVersionBranchName := anObject
]

{ #category : #ui }
ThGitHubModifiedFileStats >> newVersionLineCount [
	^ newVersionLineCount ifNil: [ newVersionLineCount := self countLines: self newContent ]
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> oldContent [
	^ oldContent ifNil: [ repository executeGitCommandOutput: self oldContentCommand ]
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> oldContentCommand [
	^ 'git show ' , oldVersionBranchName , ':' , filename
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> oldVersionBranchName [
	^ oldVersionBranchName
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> oldVersionBranchName: anObject [
	oldVersionBranchName := anObject
]

{ #category : #ui }
ThGitHubModifiedFileStats >> oldVersionLineCount [
	^ oldVersionLineCount ifNil: [ oldVersionLineCount := self countLines: self oldContent ]
]

{ #category : #printing }
ThGitHubModifiedFileStats >> printOn: aStream [
	^ aStream nextPutAll: filename; nextPutAll: ' Additions: '; print: additions; nextPutAll: ' Deletions: '; print: deletions
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> repository [
	^ repository
]

{ #category : #accessing }
ThGitHubModifiedFileStats >> repository: anObject [
	repository := anObject
]

{ #category : #testing }
ThGitHubModifiedFileStats >> wasAdded [
	^ self oldVersionLineCount = 0
]

{ #category : #testing }
ThGitHubModifiedFileStats >> wasModified [
	^ self additions ~= 0 or: [ self deletions ~= 0 ]
]

{ #category : #testing }
ThGitHubModifiedFileStats >> wasRemoved [
	^ self newVersionLineCount = 0
]
