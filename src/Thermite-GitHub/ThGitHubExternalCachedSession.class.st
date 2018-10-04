Class {
	#name : #ThGitHubExternalCachedSession,
	#superclass : #ThGitHubAbstractSession,
	#instVars : [
		'host',
		'port',
		'socket',
		'socketStream'
	],
	#category : 'Thermite-GitHub'
}

{ #category : #accessing }
ThGitHubExternalCachedSession >> host [
	^ host
]

{ #category : #accessing }
ThGitHubExternalCachedSession >> host: anObject [
	host := anObject
]

{ #category : #initialization }
ThGitHubExternalCachedSession >> initialize [
	super initialize.
	host := 'localhost'.
	port := 7692
]

{ #category : #accessing }
ThGitHubExternalCachedSession >> port [
	^ port
]

{ #category : #accessing }
ThGitHubExternalCachedSession >> port: anObject [
	port := anObject
]

{ #category : #'as yet unclassified' }
ThGitHubExternalCachedSession >> validSocket [
	| hostAddress |
	socket ifNotNil: [ ^ socket ].
	hostAddress := NetNameResolver addressForName: host.

	socket := Socket newTCP.
	socket connectTo: hostAddress port: port waitForConnectionFor: 10.
	^ socket
]

{ #category : #'as yet unclassified' }
ThGitHubExternalCachedSession >> validSocketStream [
	socketStream ifNotNil: [ ^ socketStream ].
	socketStream := SocketStream on: self validSocket.
	^ socketStream
]
