as yet unclassified
validSocket
	| hostAddress |
	socket ifNotNil: [ ^ socket ].
	hostAddress := NetNameResolver addressForName: host.

	socket := Socket newTCP.
	socket connectTo: hostAddress port: port waitForConnectionFor: 10.
	^ socket