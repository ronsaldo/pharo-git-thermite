Class {
	#name : #ThGitHubContributorStat,
	#superclass : #ThGitHubResource,
	#category : #'Thermite-GitHub'
}

{ #category : #testing }
ThGitHubContributorStat class >> isIndirectArrayElement [
	^ false
]

{ #category : #accessing }
ThGitHubContributorStat >> author [
	^ self getUser: (json at: 'author')
]

{ #category : #accessing }
ThGitHubContributorStat >> total [
	^ json at: 'total'
]
