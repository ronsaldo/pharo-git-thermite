Class {
	#name : #ThStatsCommit,
	#superclass : #Object,
	#traits : 'TThGitHubMonticelloLoading',
	#classTraits : 'TThGitHubMonticelloLoading classTrait',
	#instVars : [
		'name',
		'repository',
		'title',
		'numStat',
		'diff',
		'modifications',
		'deletions',
		'additions',
		'message',
		'sha',
		'parent',
		'parentMessage'
	],
	#category : #'Thermite-Stats-Local'
}

{ #category : #accessing }
ThStatsCommit >> additions [
	additions ifNil: [ 
		additions := 0.
		self numStat do: [ :stat |
			additions := additions + stat additions
		].
	].
	^ additions
]

{ #category : #'git commands' }
ThStatsCommit >> changeMessage [
	^ self message
]

{ #category : #'git commands' }
ThStatsCommit >> checkout [
	^ self repository executeGitCommand: self checkoutCommand
]

{ #category : #'git commands' }
ThStatsCommit >> checkoutCommand [
	^ 'git checkout ' , name
]

{ #category : #'git commands' }
ThStatsCommit >> checkoutParent [
	^ self repository executeGitCommand: self checkoutParentCommand
]

{ #category : #'git commands' }
ThStatsCommit >> checkoutParentCommand [
	^ 'git checkout ' , self parentName
]

{ #category : #'as yet unclassified' }
ThStatsCommit >> commitLog [
	^ repository executeGitCommandOutput: self commitLogCommand
]

{ #category : #'as yet unclassified' }
ThStatsCommit >> commitLogCommand [
	^ 'git log --pretty=oneline -1 {1}' format: { name }
]

{ #category : #accessing }
ThStatsCommit >> commits [
	^ ThStatsCommits new elements: { self }
]

{ #category : #accessing }
ThStatsCommit >> deletions [
	deletions ifNil: [ 
		deletions := 0.
		self numStat do: [ :stat |
			deletions := deletions + stat deletions
		].
	].
	^ deletions
]

{ #category : #accessing }
ThStatsCommit >> diff [
	^ diff ifNil: [ diff := self doGetDiff ]
]

{ #category : #'git commands' }
ThStatsCommit >> diffCommand [
	^ 'git diff ' , self name , ' ' , self parentName
]

{ #category : #modifications }
ThStatsCommit >> doFindModifications [
	| filenames repo oldContents newContents |
	filenames := self modifiedFilenames.
	
	repo := self repository.
	self checkoutParent.
	
	oldContents := filenames collect: [ :filename | repo getFileContent: filename ifAbsent: [nil]].
	
	self fetch; checkout.
	newContents := filenames collect: [ :filename | repo getFileContent: filename ifAbsent: [nil]].
	^ (filenames collectWithIndex: [ :filename :index |
		ThGitHubFileDifference new
			filename: filename;
			oldContent: (oldContents at: index);
			newContent: (newContents at: index);
			yourself
	]) select: #isValid
]

{ #category : #'git commands' }
ThStatsCommit >> doGetDiff [
	^ ThGitHubDiffColorizer colorize: (self repository executeGitCommandOutput: self diffCommand)
]

{ #category : #'git commands' }
ThStatsCommit >> doNumStat [
	| statString parts repo oldVersionBranchName newVersionBranchName |
	self flag: 'Handle the renamed files in a better way.'.
	
	self fetch.
	statString :=  self repository executeGitCommandOutput: self numStatCommand.
	repo := self repository.
	oldVersionBranchName := self parentName.
	newVersionBranchName := self name.
	^ (statString lines reject: [:line | line includesSubstring: ' => '] thenCollect: [ :line |
		parts := line splitOn: Character tab.
		(parts first isAllDigits and: [ parts second isAllDigits ]) ifTrue: [
			ThGitHubModifiedFileStats new
				filename: parts last;
				additions: parts first asNumber;
				deletions: parts second asNumber;
				repository: repo;
				oldVersionBranchName: oldVersionBranchName;
				newVersionBranchName: newVersionBranchName
				yourself
		] ifFalse: [
			nil
		]
	]) select: #isNotNil
]

{ #category : #actions }
ThStatsCommit >> fetch [
	"Do nothing"
]

{ #category : #'git commands' }
ThStatsCommit >> getHashCommand [
	^ 'git log --format=%H -n 1 ' , self name
]

{ #category : #'git commands' }
ThStatsCommit >> getMessageCommand [
	^ 'git log --format=%B -n 1 ' , self name
]

{ #category : #'git commands' }
ThStatsCommit >> getParentMessageCommand [
	^ 'git log --format=%B -n 1 ' , self parentName
]

{ #category : #initialization }
ThStatsCommit >> initialize [
	super initialize.
	parent := '^1'
]

{ #category : #'pull request mock' }
ThStatsCommit >> mergeable [
	^ nil
]

{ #category : #'git commands' }
ThStatsCommit >> message [
	^ message ifNil: [ message := (self repository executeGitCommandOutput: self getMessageCommand) ]
]

{ #category : #accessing }
ThStatsCommit >> modifications [
	^ modifications ifNil: [ modifications := self doFindModifications ]
]

{ #category : #accessing }
ThStatsCommit >> modifiedFilenames [
	^ self numStat collect: #filename
]

{ #category : #accessing }
ThStatsCommit >> name [
	^ name
]

{ #category : #accessing }
ThStatsCommit >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ThStatsCommit >> numStat [
	^ numStat ifNil: [ numStat := self doNumStat ]
]

{ #category : #'git commands' }
ThStatsCommit >> numStatCommand [
	^ 'git diff --numstat ' , name, ' ' , self parentName
]

{ #category : #accessing }
ThStatsCommit >> parent [
	^ parent
]

{ #category : #accessing }
ThStatsCommit >> parent: anObject [
	parent := anObject
]

{ #category : #'git commands' }
ThStatsCommit >> parentMessage [
	^ parentMessage ifNil: [ parentMessage := (self repository executeGitCommandOutput: self getParentMessageCommand) ]
]

{ #category : #accessing }
ThStatsCommit >> parentName [
	((parent beginsWith: '^') or: [ parent beginsWith: '~' ]) ifTrue: [ ^ name , parent ].
	^ parent
]

{ #category : #'git commands' }
ThStatsCommit >> parentsSha [
	^ { self parentName }
]

{ #category : #accessing }
ThStatsCommit >> repository [
	^ repository
]

{ #category : #accessing }
ThStatsCommit >> repository: anObject [
	repository := anObject
]

{ #category : #'git commands' }
ThStatsCommit >> sha [
	^ sha ifNil: [ sha := (self repository executeGitCommandOutput: self getHashCommand) ]
]

{ #category : #accessing }
ThStatsCommit >> title [
	| log |
	title ifNil: [
		log := self commitLog lines first.
		title := log allButFirst: (log indexOf: Character space)
	].
	^ title
]
