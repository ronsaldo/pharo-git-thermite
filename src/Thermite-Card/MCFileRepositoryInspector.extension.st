Extension { #name : #MCFileRepositoryInspector }

{ #category : #'*Thermite-Card' }
MCFileRepositoryInspector >> versionFromVersionInfo: aVersionInfo [
	^ repository versionFromFileNamed: aVersionInfo name , '.mcz'
]
