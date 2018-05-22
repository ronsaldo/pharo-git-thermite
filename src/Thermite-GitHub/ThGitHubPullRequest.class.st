Class {
	#name : #ThGitHubPullRequest,
	#superclass : #ThGitHubResource,
	#traits : 'TThGitHubMonticelloLoading',
	#classTraits : 'TThGitHubMonticelloLoading classTrait',
	#instVars : [
		'modifications',
		'diff',
		'numStat',
		'commits'
	],
	#category : #'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubPullRequest >> baseSha [
	^ (json at: 'base') at: 'sha'
]

{ #category : #'git commands' }
ThGitHubPullRequest >> checkout [
	^ self repository executeGitCommand: self checkoutCommand
]

{ #category : #'git commands' }
ThGitHubPullRequest >> checkoutCommand [
	^ 'git checkout ' , self localHeadBranchName
]

{ #category : #'git commands' }
ThGitHubPullRequest >> checkoutParent [
	^ self repository executeGitCommand: self checkoutParentCommand
]

{ #category : #'git commands' }
ThGitHubPullRequest >> checkoutParentCommand [
	^ 'git checkout ' , self parentSha
]

{ #category : #accessing }
ThGitHubPullRequest >> comments [
	^ session getCachedResource: (json at: 'comments_url') arrayElementClass: ThGitHubComment
]

{ #category : #accessing }
ThGitHubPullRequest >> commits [
	^ commits ifNil: [ commits := session getCachedResource: (json at: 'commits_url') arrayElementClass: ThGitHubCommit ]
]

{ #category : #'git commands' }
ThGitHubPullRequest >> diff [
	^ diff ifNil: [ diff := self doGetDiff ]
]

{ #category : #'git commands' }
ThGitHubPullRequest >> diffCommand [
	^ 'git --no-pager diff ' , self parentSha , ' ' , self localHeadBranchName 
]

{ #category : #modifications }
ThGitHubPullRequest >> doFindModifications [
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
ThGitHubPullRequest >> doGetDiff [
	^ ThGitHubDiffColorizer colorize: (self repository executeGitCommandOutput: self diffCommand)
]

{ #category : #'git commands' }
ThGitHubPullRequest >> doNumStat [
	| statString parts repo oldVersionBranchName newVersionBranchName |
	self flag: 'Handle the renamed files in a better way.'.
	
	self fetch.
	statString :=  self repository executeGitCommandOutput: self numStatCommand.
	repo := self repository.
	oldVersionBranchName := self parentSha.
	newVersionBranchName := self localHeadBranchName.
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

{ #category : #'git commands' }
ThGitHubPullRequest >> fetch [
	^ self repository executeGitCommand: self fetchCommand
]

{ #category : #'git commands' }
ThGitHubPullRequest >> fetchCommand [
	^ 'git fetch origin ' , self remoteHeadBranchName , ':' , self localHeadBranchName
]

{ #category : #accessing }
ThGitHubPullRequest >> localHeadBranchName [
	^ 'pull_' , self number asString
]

{ #category : #accessing }
ThGitHubPullRequest >> mergeable [
	^ json at: 'mergeable'
]

{ #category : #accessing }
ThGitHubPullRequest >> merged [
	^ json at: 'merged'
]

{ #category : #accessing }
ThGitHubPullRequest >> mergedAt [
	^ DateAndTime fromString: (json at: 'merged_at')
]

{ #category : #accessing }
ThGitHubPullRequest >> mergedBy [
	^ self getUser: (json at: 'merged_by')
]

{ #category : #modifications }
ThGitHubPullRequest >> modifications [
	^ modifications ifNil: [ modifications := self doFindModifications ]
]

{ #category : #modifications }
ThGitHubPullRequest >> modifiedFilenames [
	^ self numStat collect: #filename
]

{ #category : #accessing }
ThGitHubPullRequest >> name [
	^ self title
]

{ #category : #'git commands' }
ThGitHubPullRequest >> numStat [
	^ numStat ifNil: [ numStat := self doNumStat ]
]

{ #category : #'git commands' }
ThGitHubPullRequest >> numStatCommand [
	^ 'git --no-pager diff --numstat ' , self parentSha , ' ' , self localHeadBranchName 
]

{ #category : #accessing }
ThGitHubPullRequest >> number [
	^ json at: 'number'
]

{ #category : #accessing }
ThGitHubPullRequest >> numberOfAdditions [
	^ json at: 'additions'
]

{ #category : #accessing }
ThGitHubPullRequest >> numberOfComments [
	^ json at: 'comments'
]

{ #category : #accessing }
ThGitHubPullRequest >> numberOfCommits [
	^ json at: 'commits'
]

{ #category : #accessing }
ThGitHubPullRequest >> numberOfDeletions [
	^ json at: 'deletions'
]

{ #category : #accessing }
ThGitHubPullRequest >> parentName [
	^ self baseSha
]

{ #category : #accessing }
ThGitHubPullRequest >> parentSha [
	^ self parentsSha first
]

{ #category : #accessing }
ThGitHubPullRequest >> parentsSha [
	^ self commits first parentsSha
]

{ #category : #accessing }
ThGitHubPullRequest >> printOn: aStream [
	super printOn: aStream.
	aStream space; print: self title
]

{ #category : #accessing }
ThGitHubPullRequest >> remoteHeadBranchName [
	^ 'pull/' , self number asString , '/head'
]

{ #category : #accessing }
ThGitHubPullRequest >> repository [
	^ parent
]

{ #category : #accessing }
ThGitHubPullRequest >> state [
	^ json at: 'state'
]

{ #category : #accessing }
ThGitHubPullRequest >> title [
	^ json at: 'title'
]

{ #category : #accessing }
ThGitHubPullRequest >> user [
	^ self getUser: (json at: 'user')
]
