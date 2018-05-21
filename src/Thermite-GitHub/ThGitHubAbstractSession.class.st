Class {
	#name : #ThGitHubAbstractSession,
	#superclass : #Object,
	#instVars : [
		'repositoriesRoot'
	],
	#category : #'Thermite-GitHub'
}

{ #category : #'as yet unclassified' }
ThGitHubAbstractSession class >> defaultRepositoriesRoot [
	^ FileSystem workingDirectory / 'repositories'
]

{ #category : #resources }
ThGitHubAbstractSession >> get: url [
	| header headerParts contentSize content |
	self validSocketStream
		nextPutAll: 'get ' , url , String lf;
		flush.
	header := self validSocketStream upToAll: String lf.
	headerParts := header substrings.
	contentSize := headerParts third asInteger.
	content := self validSocketStream next: contentSize.
	self assert: self validSocketStream next = Character lf.

	^ ThGitHubExternalCacheResponse new
		code: headerParts first asInteger;
		message: headerParts second;
		content: content;
		yourself
	
]

{ #category : #resources }
ThGitHubAbstractSession >> getCachedResource: url arrayElementClass: arrayElementClass [
	^ self getCachedResource: url arrayElementClass: arrayElementClass parent: nil
]

{ #category : #resources }
ThGitHubAbstractSession >> getCachedResource: url arrayElementClass: arrayElementClass parent: elementParent [
	^ self getCachedResource: url class: (ThGitHubArrayResource new elementClass: arrayElementClass) parent: elementParent
]

{ #category : #resources }
ThGitHubAbstractSession >> getCachedResource: url class: resourceClass [
	^ self getCachedResource: url class: resourceClass parent: nil
]

{ #category : #resources }
ThGitHubAbstractSession >> getCachedResource: url class: resourceClass parent: parent [
	| response responseContent resource |
	response := self get: url.
	responseContent := NeoJSONReader fromString: response content.
	
	resource := resourceClass new.
	resource
		session: self;
		url: url;
		json: (responseContent at: 'content');
		etag: (responseContent at: 'etag');
		link: (responseContent at: 'link' ifAbsent: [nil]);
		lastDownloadTime: DateAndTime now;
		parent: parent.
	resource loaded.
	^ resource
	
]

{ #category : #initialization }
ThGitHubAbstractSession >> initialize [
	super initialize.
	repositoriesRoot := self class defaultRepositoriesRoot
]

{ #category : #resources }
ThGitHubAbstractSession >> organization: organizationName repository: repositoryName [
	^ self getCachedResource: 'https://api.github.com/repos/' , organizationName , '/', repositoryName class: ThGitHubRepository
]

{ #category : #accessing }
ThGitHubAbstractSession >> repositoriesRoot [
	^ repositoriesRoot
]

{ #category : #accessing }
ThGitHubAbstractSession >> repositoriesRoot: anObject [
	repositoriesRoot := anObject
]

{ #category : #resources }
ThGitHubAbstractSession >> user [
	^ self getCachedResource: 'https://api.github.com/user' class: ThGitHubUser
]

{ #category : #resources }
ThGitHubAbstractSession >> user: userName repository: repositoryName [
	^ self getCachedResource: 'https://api.github.com/repos/' , userName , '/', repositoryName class: ThGitHubRepository
]
