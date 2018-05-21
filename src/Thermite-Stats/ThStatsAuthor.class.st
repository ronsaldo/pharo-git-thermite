Class {
	#name : #ThStatsAuthor,
	#superclass : #Object,
	#instVars : [
		'name',
		'commitCount',
		'pullRequests',
		'acceptedPullRequests',
		'rejectedPullRequests',
		'openPullRequests',
		'followerCount',
		'publicRepositoryCount',
		'publicRepositoriesForkCount'
	],
	#category : #'Thermite-Stats'
}

{ #category : #accessing }
ThStatsAuthor >> acceptedPullRequests [
	^ acceptedPullRequests
]

{ #category : #accessing }
ThStatsAuthor >> acceptedPullRequests: anObject [
	acceptedPullRequests := anObject
]

{ #category : #adding }
ThStatsAuthor >> addCommits: count [
	commitCount := commitCount + count
]

{ #category : #adding }
ThStatsAuthor >> addPullRequest: pullRequest [
	| state |
	state := pullRequest state.
	pullRequests := pullRequests + 1.
	
	state = 'open' ifTrue: [
		openPullRequests := openPullRequests + 1.
	] ifFalse: [ 
		self assert: state = 'closed'.
		pullRequest merged ifTrue: [
			acceptedPullRequests := acceptedPullRequests + 1
		] ifFalse: [
			rejectedPullRequests := rejectedPullRequests + 1
		]
	]
	
]

{ #category : #accessing }
ThStatsAuthor >> commitCount [
	^ commitCount
]

{ #category : #accessing }
ThStatsAuthor >> commitCount: anObject [
	commitCount := anObject
]

{ #category : #accessing }
ThStatsAuthor >> followerCount [
	^ followerCount
]

{ #category : #accessing }
ThStatsAuthor >> followerCount: anObject [
	followerCount := anObject
]

{ #category : #initialization }
ThStatsAuthor >> initialize [
	super initialize.
	commitCount := 0.
	pullRequests := 0.
	acceptedPullRequests := 0.
	openPullRequests := 0.
	rejectedPullRequests := 0.
	followerCount := 0.
	publicRepositoryCount := 0.
	publicRepositoriesForkCount := 0.
]

{ #category : #accessing }
ThStatsAuthor >> name [
	^ name
]

{ #category : #accessing }
ThStatsAuthor >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ThStatsAuthor >> openPullRequests [
	^ openPullRequests
]

{ #category : #accessing }
ThStatsAuthor >> openPullRequests: anObject [
	openPullRequests := anObject
]

{ #category : #accessing }
ThStatsAuthor >> publicRepositoriesForkCount [
	^ publicRepositoriesForkCount
]

{ #category : #accessing }
ThStatsAuthor >> publicRepositoriesForkCount: anObject [
	publicRepositoriesForkCount := anObject
]

{ #category : #accessing }
ThStatsAuthor >> publicRepositoryCount [
	^ publicRepositoryCount
]

{ #category : #accessing }
ThStatsAuthor >> publicRepositoryCount: anObject [
	publicRepositoryCount := anObject
]

{ #category : #accessing }
ThStatsAuthor >> pullRequests [
	^ pullRequests
]

{ #category : #accessing }
ThStatsAuthor >> pullRequests: anObject [
	pullRequests := anObject
]

{ #category : #accessing }
ThStatsAuthor >> rejectedPullRequests [
	^ rejectedPullRequests
]

{ #category : #accessing }
ThStatsAuthor >> rejectedPullRequests: anObject [
	rejectedPullRequests := anObject
]
