accessing
validName
	self name ifNotNil: [ :result | ^ result ].
	self email ifNotNil: [ :result | ^ result ].
	self login ifNotNil: [ :result | ^ result ].
	self halt.