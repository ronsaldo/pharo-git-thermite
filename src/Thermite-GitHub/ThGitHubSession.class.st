Class {
	#name : #ThGitHubSession,
	#superclass : #ThGitHubAbstractSession,
	#instVars : [
		'username',
		'password',
		'urlCache',
		'rateLimit',
		'rateLimitRemaining',
		'rateLimitReset',
		'currentClient'
	],
	#classVars : [
		'GitHubMimeType',
		'MainUserAccessToken',
		'MainUserName',
		'RedownloadCacheTime'
	],
	#category : #'Thermite-GitHub'
}

{ #category : #'as yet unclassified' }
ThGitHubSession class >> forMainUser [
	^ self username: self mainUserName token: self mainUserAccessToken
]

{ #category : #'as yet unclassified' }
ThGitHubSession class >> gitHubSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #githubApi)
		label: 'GitHub';
		description: 'GitHub related settings';
		with: [
			(aBuilder setting: #gitHubMainUserName)
				label: 'Main User Name';
				target: self;
				getSelector: #mainUserName;
				setSelector: #mainUserName:.
		
			(aBuilder setting: #gitHubMainUserAccessToken)
				label: 'Main User Access Token';
				target: self;
				getSelector: #mainUserAccessToken;
				setSelector: #mainUserAccessToken:.
				
		]
]

{ #category : #initialization }
ThGitHubSession class >> initialize [
	GitHubMimeType := 'application/vnd.github.v3+json'.
	RedownloadCacheTime := 24 hours.
]

{ #category : #'as yet unclassified' }
ThGitHubSession class >> mainUserAccessToken [
	^ MainUserAccessToken ifNil: [ MainUserAccessToken := '' ]
]

{ #category : #'as yet unclassified' }
ThGitHubSession class >> mainUserAccessToken: aString [
	^ MainUserAccessToken := aString
]

{ #category : #'as yet unclassified' }
ThGitHubSession class >> mainUserName [
	^ MainUserName ifNil: [ MainUserName := '' ]
]

{ #category : #'as yet unclassified' }
ThGitHubSession class >> mainUserName: aString [
	^ MainUserName := aString
]

{ #category : #'instance creation' }
ThGitHubSession class >> username: username password: password [
	^ self new
		username: username;
		password: password;
		yourself
]

{ #category : #'instance creation' }
ThGitHubSession class >> username: username token: token [
	^ self new
		username: username;
		token: token;
		yourself
]

{ #category : #public }
ThGitHubSession >> get: url [
	^ self zincClient
		get: url;
		response
]

{ #category : #resources }
ThGitHubSession >> getCachedResource: url class: resourceClass parent: aParent [
	^ urlCache at: url ifPresent: [:cachedResource |
		self updateCachedResource: cachedResource class: resourceClass parent: aParent
	] ifAbsentPut: [
		self getUncachedResource: url class: resourceClass parent: aParent
	]
]

{ #category : #public }
ThGitHubSession >> getJson: url [
	^ NeoJSONReader fromString: (self get: url) contents
]

{ #category : #resources }
ThGitHubSession >> getUncachedResource: url class: resourceClass parent: parent [
	| response resource |
	response := self get: url.
	self updateRateLimits: response.
	resource := resourceClass new.
	self traceDownload: url.
	resource
		session: self;
		url: url;
		json: (NeoJSONReader fromString: response contents);
		etag: (response headers at: 'ETag');
		link: (response headers at: 'Link' ifAbsent: [nil]);
		lastDownloadTime: DateAndTime now;
		parent: parent.
	resource loaded.
	^ resource
]

{ #category : #initialization }
ThGitHubSession >> initialize [
	super initialize.
	
	urlCache := Dictionary new.
]

{ #category : #accessing }
ThGitHubSession >> password [
	^ password
]

{ #category : #accessing }
ThGitHubSession >> password: anObject [
	password := anObject
]

{ #category : #accessing }
ThGitHubSession >> token [
	^ password
]

{ #category : #accessing }
ThGitHubSession >> token: anObject [
	password := anObject
]

{ #category : #resources }
ThGitHubSession >> traceDownload: url [
	Transcript show: 'Get ', url; cr.
]

{ #category : #resources }
ThGitHubSession >> updateCachedResource: resource class: resourceClass parent: parent [
	| client response |
	"Avoid immediate redownloading."
	(DateAndTime now - resource lastDownloadTime < RedownloadCacheTime) ifTrue: [
		^ resource
	].

	self traceDownload: resource url.
	client := self zincClient.
	client 
		url: resource url.
	client headerAt: 'If-None-Match' put: resource etag.
	response := client get; response.
	self updateRateLimits: response.
	response status = 304 ifTrue: [ ^ resource ].
	resource
		json: (NeoJSONReader fromString: response contents);
		etag: (response headers at: 'ETag');
		link: (response headers at: 'Link' ifAbsent: [nil]);
		lastDownloadTime: DateAndTime now;
		parent: parent.
	resource updated.
	^ resource
]

{ #category : #'rate limit' }
ThGitHubSession >> updateRateLimits: response [
	rateLimit := (response headers at: 'X-RateLimit-Limit') asInteger.
	rateLimitRemaining := (response headers at: 'X-RateLimit-Remaining') asInteger.
	rateLimitReset := (response headers at: 'X-RateLimit-Reset') asInteger.
]

{ #category : #accessing }
ThGitHubSession >> username [
	^ username
]

{ #category : #accessing }
ThGitHubSession >> username: anObject [
	username := anObject
]

{ #category : #public }
ThGitHubSession >> zincClient [
	currentClient ifNotNil: [ ^ currentClient ].
	currentClient := ZnClient new
		accept: GitHubMimeType;
		username: username password: password.
	^ currentClient
]
