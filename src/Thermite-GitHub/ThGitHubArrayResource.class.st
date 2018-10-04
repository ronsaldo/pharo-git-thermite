Class {
	#name : #ThGitHubArrayResource,
	#superclass : #ThGitHubResource,
	#instVars : [
		'elementClass'
	],
	#category : 'Thermite-GitHub'
}

{ #category : #'private-model' }
ThGitHubArrayResource >> allItems [
	^ self collect: #yourself
]

{ #category : #accessing }
ThGitHubArrayResource >> at: index [
	| elementUrl |
	elementClass isIndirectArrayElement ifFalse: [
		^ elementClass new
			session: session;
			json: (json at: index);
			parent: parent;
			yourself
	].
	elementUrl := (json at: index) at: 'url'.
	^ session getCachedResource: elementUrl class: elementClass parent: parent
]

{ #category : #enumerating }
ThGitHubArrayResource >> collect: aBlock [
	^ Array streamContents: [ :out |
		self do: [ :element |
			out nextPut: (aBlock value: element)
		]
	]
]

{ #category : #enumerating }
ThGitHubArrayResource >> do: aBlock [
	self pageDo: aBlock.
	self nextPage ifNotNil: [ :nextPage | nextPage do: aBlock ]
]

{ #category : #accessing }
ThGitHubArrayResource >> elementClass [
	^ elementClass
]

{ #category : #accessing }
ThGitHubArrayResource >> elementClass: anObject [
	elementClass := anObject
]

{ #category : #accessing }
ThGitHubArrayResource >> first [
	^ self at: 1
]

{ #category : #pagination }
ThGitHubArrayResource >> firstLink [
	^ links at: 'first' ifAbsent: [ nil ]
]

{ #category : #pagination }
ThGitHubArrayResource >> firstPage [
	^ self getLinkedPage: self firstLink
]

{ #category : #accessing }
ThGitHubArrayResource >> fourth [
	^ self at: 4
]

{ #category : #pagination }
ThGitHubArrayResource >> getLinkedPage: link [
	link ifNil: [ ^ nil ].
	^ session getCachedResource: link arrayElementClass: elementClass
]

{ #category : #pagination }
ThGitHubArrayResource >> lastLink [
	^ links at: 'last' ifAbsent: [ nil ]
]

{ #category : #pagination }
ThGitHubArrayResource >> lastPage [
	^ self getLinkedPage: self lastLink
]

{ #category : #'instance creation' }
ThGitHubArrayResource >> new [
	^ self
]

{ #category : #pagination }
ThGitHubArrayResource >> nextLink [
	^ links at: 'next' ifAbsent: [ nil ]
]

{ #category : #pagination }
ThGitHubArrayResource >> nextPage [
	^ self getLinkedPage: self nextLink
]

{ #category : #accessing }
ThGitHubArrayResource >> pageDo: aBlock [
	1 to: self size do: [ :i | aBlock value: (self at: i) ]
]

{ #category : #pagination }
ThGitHubArrayResource >> prevLink [
	^ links at: 'prev' ifAbsent: [ nil ]
]

{ #category : #pagination }
ThGitHubArrayResource >> prevPage [
	^ self getLinkedPage: self prevLink
]

{ #category : #enumerating }
ThGitHubArrayResource >> reject: aBlock [
	^ Array streamContents: [ :out |
		self do: [ :element |
			(aBlock value: element) ifFalse: [ 
				out nextPut: element
			]
		]
	]
]

{ #category : #enumerating }
ThGitHubArrayResource >> reject: aBlock thenCollect: collectBlock [
	^ Array streamContents: [ :out |
		self do: [ :element |
			(aBlock value: element) ifFalse: [ 
				out nextPut: (collectBlock value: element)
			]
		]
	]
]

{ #category : #enumerating }
ThGitHubArrayResource >> reject: aBlock thenDo: doBlock [
	self do: [ :element |
		(aBlock value: element) ifFalse: [ 
			doBlock value: element
		]
	]

]

{ #category : #accessing }
ThGitHubArrayResource >> second [
	^ self at: 2
]

{ #category : #enumerating }
ThGitHubArrayResource >> select: aBlock [
	^ Array streamContents: [ :out |
		self do: [ :element |
			(aBlock value: element) ifTrue: [ 
				out nextPut: element
			]
		]
	]
]

{ #category : #enumerating }
ThGitHubArrayResource >> select: aBlock thenCollect: collectBlock [
	^ Array streamContents: [ :out |
		self do: [ :element |
			(aBlock value: element) ifTrue: [ 
				out nextPut: (collectBlock value: element)
			]
		]
	]
]

{ #category : #enumerating }
ThGitHubArrayResource >> select: aBlock thenDo: doBlock [
	self do: [ :element |
		(aBlock value: element) ifTrue: [ 
			doBlock value: element
		]
	]

]

{ #category : #accessing }
ThGitHubArrayResource >> size [
	self assert: json isArray.
	^ json size
]

{ #category : #accessing }
ThGitHubArrayResource >> third [
	^ self at: 3
]
