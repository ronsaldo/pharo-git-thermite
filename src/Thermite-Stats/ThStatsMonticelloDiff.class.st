Class {
	#name : #ThStatsMonticelloDiff,
	#superclass : #Object,
	#instVars : [
		'title',
		'oldPackages',
		'newPackages'
	],
	#classVars : [
		'ProcessWaitDelay'
	],
	#category : #'Thermite-Stats-LocalMonticello'
}

{ #category : #diff }
ThStatsMonticelloDiff >> additions [
	self flag: 'Implement myself'.
	^ 0
]

{ #category : #accessing }
ThStatsMonticelloDiff >> commits [
	^ ThStatsCommits new elements: { self }
]

{ #category : #diff }
ThStatsMonticelloDiff >> deletions [
	self flag: 'Implement myself'.
	^ 0
]

{ #category : #diff }
ThStatsMonticelloDiff >> diff [
	^ 'TODO: Implement myself for Monticello'
]

{ #category : #initialization }
ThStatsMonticelloDiff >> initialize [
	super initialize.
	title := 'Monticello Diff'.
	
]

{ #category : #accessing }
ThStatsMonticelloDiff >> loadOldAndNewMonticelloPackages [
	^ { oldPackages . newPackages }
]

{ #category : #accessing }
ThStatsMonticelloDiff >> mergeable [
	^ nil
]

{ #category : #accessing }
ThStatsMonticelloDiff >> newPackages [
	^ newPackages
]

{ #category : #accessing }
ThStatsMonticelloDiff >> newPackages: anObject [
	newPackages := anObject
]

{ #category : #accessing }
ThStatsMonticelloDiff >> numStat [
	^ #()
]

{ #category : #accessing }
ThStatsMonticelloDiff >> oldPackages [
	^ oldPackages
]

{ #category : #accessing }
ThStatsMonticelloDiff >> oldPackages: anObject [
	oldPackages := anObject
]

{ #category : #'fake commit' }
ThStatsMonticelloDiff >> parentsSha [
	^ #()
]

{ #category : #'fake commit' }
ThStatsMonticelloDiff >> sha [
	^ ''
]

{ #category : #accessing }
ThStatsMonticelloDiff >> title [
	^ title
]

{ #category : #accessing }
ThStatsMonticelloDiff >> title: anObject [
	title := anObject
]
