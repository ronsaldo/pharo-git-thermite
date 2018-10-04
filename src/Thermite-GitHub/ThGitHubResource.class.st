Class {
	#name : #ThGitHubResource,
	#superclass : #Object,
	#instVars : [
		'session',
		'etag',
		'url',
		'json',
		'links',
		'lastDownloadTime',
		'parent'
	],
	#classVars : [
		'EmptyLinks'
	],
	#category : 'Thermite-GitHub'
}

{ #category : #initialization }
ThGitHubResource class >> initialize [
	EmptyLinks := Dictionary new.
]

{ #category : #testing }
ThGitHubResource class >> isIndirectArrayElement [
	^ true
]

{ #category : #accessing }
ThGitHubResource >> etag [
	^ etag
]

{ #category : #accessing }
ThGitHubResource >> etag: anObject [
	etag := anObject
]

{ #category : #utilities }
ThGitHubResource >> getUser: userData [
	userData ifNil: [ ^ nil ].
	^ session getCachedResource: (userData at: 'url') class: ThGitHubUser
]

{ #category : #'gt-inspector-extension' }
ThGitHubResource >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 9> 
	json ifNil: [ ^ nil ].
	^ json gtInspectorItemsIn: composite
]

{ #category : #initialization }
ThGitHubResource >> initialize [
	super initialize.
	links := EmptyLinks.
	
]

{ #category : #accessing }
ThGitHubResource >> json [
	^ json
]

{ #category : #accessing }
ThGitHubResource >> json: anObject [
	json := anObject
]

{ #category : #accessing }
ThGitHubResource >> lastDownloadTime [
	^ lastDownloadTime
]

{ #category : #accessing }
ThGitHubResource >> lastDownloadTime: anObject [
	lastDownloadTime := anObject
]

{ #category : #accessing }
ThGitHubResource >> link: linkString [
	(linkString isNil or: [ linkString isEmpty ]) ifTrue: [
		links := EmptyLinks.
	] ifFalse: [
		links := Dictionary new.
		(ThGitHubLinkParser new parse: linkString) do: [ :link |
			links at: (link second at: 'rel') put: link first
		]
	]
]

{ #category : #accessing }
ThGitHubResource >> links [
	^ links
]

{ #category : #events }
ThGitHubResource >> loaded [
]

{ #category : #accessing }
ThGitHubResource >> parent [
	^ parent
]

{ #category : #accessing }
ThGitHubResource >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
ThGitHubResource >> session [
	^ session
]

{ #category : #accessing }
ThGitHubResource >> session: anObject [
	session := anObject
]

{ #category : #events }
ThGitHubResource >> updated [
]

{ #category : #accessing }
ThGitHubResource >> url [
	^ url
]

{ #category : #accessing }
ThGitHubResource >> url: anObject [
	url := anObject
]
