Class {
	#name : #ThGitHubRepository,
	#superclass : #ThGitHubResource,
	#classVars : [
		'ProcessWaitDelay'
	],
	#category : 'Thermite-GitHub'
}

{ #category : #initialization }
ThGitHubRepository class >> initialize [
	ProcessWaitDelay := Delay forMilliseconds: 100
]

{ #category : #accessing }
ThGitHubRepository >> allPullRequests [
	^ session getCachedResource: url , '/pulls?state=all' arrayElementClass: ThGitHubPullRequest parent: self
]

{ #category : #'git commands' }
ThGitHubRepository >> cloneCacheName [
	^ self ownerLogin , '_' , self name 
]

{ #category : #'git commands' }
ThGitHubRepository >> cloneCommand [
	^ 'git clone ' , self cloneUrl , ' "', self clonePath , '"'
]

{ #category : #'git commands' }
ThGitHubRepository >> cloneFileReference [
	^ session repositoriesRoot / self cloneCacheName
]

{ #category : #'git commands' }
ThGitHubRepository >> clonePath [
	^ self cloneFileReference fullName
]

{ #category : #'git commands' }
ThGitHubRepository >> cloneRepo [
	self cloneFileReference exists ifTrue: [ ^ true ].
	OSSUnixSubprocess new
		shellCommand: self cloneCommand;
		runAndWaitOnExitDo: [ :process :outString :errString |
	].
	FileStream stdout nextPutAll: 'Clone done.'; lf.
]

{ #category : #accessing }
ThGitHubRepository >> cloneUrl [
	^ json at: 'clone_url'
]

{ #category : #accessing }
ThGitHubRepository >> contributorStats [
	^ session getCachedResource: url , '/stats/contributors' arrayElementClass: ThGitHubContributorStat
]

{ #category : #accessing }
ThGitHubRepository >> contributors [
	^ session getCachedResource: url , '/contributors' arrayElementClass: ThGitHubUser
]

{ #category : #'git commands' }
ThGitHubRepository >> executeGitCommand: command [
	OSSUnixSubprocess new
		workingDirectory: self clonePath;
		shellCommand: command;
		runAndWaitOnExitDo: [ :process :outString :errString |
	]
]

{ #category : #'git commands' }
ThGitHubRepository >> executeGitCommandOutput: command [
	OSSUnixSubprocess new
		workingDirectory: self clonePath;
		shellCommand: command;
		redirectStdout;
		redirectStderr;
		runAndWaitPollingEvery: (Delay forMilliseconds: 20) retrievingStreams: true onExitDo: [ :process :outString :errString |
			^ outString
	]
]

{ #category : #accessing }
ThGitHubRepository >> forksCount [
	^ json at: 'forks_count'
]

{ #category : #accessing }
ThGitHubRepository >> getFileContent: filename ifAbsent: aBlock [
	| fullReference |
	fullReference := self cloneFileReference resolve: filename asFileReference.
	^ fullReference exists ifTrue: [ fullReference contents ] ifFalse: [ aBlock value ]
]

{ #category : #accessing }
ThGitHubRepository >> name [
	^ json at: 'name'
]

{ #category : #accessing }
ThGitHubRepository >> openIssues [
	^ json at: 'open_issues'
]

{ #category : #accessing }
ThGitHubRepository >> openPullRequests [
	^ session getCachedResource: url , '/pulls?state=open' arrayElementClass: ThGitHubPullRequest parent: self
]

{ #category : #accessing }
ThGitHubRepository >> ownerLogin [
	^ (json at: 'owner') at: 'login'
]

{ #category : #accessing }
ThGitHubRepository >> pullRequestNumber: number [
	^ session getCachedResource: url , '/pulls/' , number asString class: ThGitHubPullRequest parent: self
]

{ #category : #accessing }
ThGitHubRepository >> pullRequests [
	^ session getCachedResource: url , '/pulls' arrayElementClass: ThGitHubPullRequest parent: self
]

{ #category : #accessing }
ThGitHubRepository >> size [
	^ json at: 'size'
]

{ #category : #accessing }
ThGitHubRepository >> subscribersCount [
	^ json at: 'subscribers_count'
]
