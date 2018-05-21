Class {
	#name : #ThStatsAuthorAggregator,
	#superclass : #Object,
	#instVars : [
		'authors'
	],
	#category : #'Thermite-Stats'
}

{ #category : #adding }
ThStatsAuthorAggregator >> addAuthorStats: anAuthor [
	| author |
	author := self authorFor: anAuthor.
	author followerCount: anAuthor followerCount.
	author publicRepositoryCount: anAuthor publicRepositoryCount.
	"author publicRepositoryCount > 0 ifTrue: [
		author publicRepositoriesForkCount: 0.
		anAuthor repositories do: [ :repo |
			author publicRepositoriesForkCount: author publicRepositoriesForkCount + repo forksCount.
		]
	]"
	
]

{ #category : #adding }
ThStatsAuthorAggregator >> addAuthorsStats: someAuthors [
	someAuthors do: [ :author | self addAuthorStats: author]
]

{ #category : #adding }
ThStatsAuthorAggregator >> addContributorStats: aRepository [
	aRepository contributorStats do: [ :contributorStats |
		(self authorFor: contributorStats author) addCommits: contributorStats total.
	].
]

{ #category : #adding }
ThStatsAuthorAggregator >> addContributorsToRepository: aRepository [
	self addContributorStats: aRepository.
	self addPullRequestStats: aRepository.

]

{ #category : #adding }
ThStatsAuthorAggregator >> addPullRequestStats: aRepository [
	| author |
	aRepository allPullRequests do: [ :pullRequest |
		author := self authorFor: pullRequest user.
		author addPullRequest: pullRequest
	].
]

{ #category : #'as yet unclassified' }
ThStatsAuthorAggregator >> authorFor: gitHubAuthor [
	^ authors at: gitHubAuthor validName ifAbsentPut: [ ThStatsAuthor new name: gitHubAuthor validName]
]

{ #category : #accessing }
ThStatsAuthorAggregator >> authors [
	^ authors values
]

{ #category : #initialization }
ThStatsAuthorAggregator >> initialize [
	super initialize.
	authors := Dictionary new.
]
