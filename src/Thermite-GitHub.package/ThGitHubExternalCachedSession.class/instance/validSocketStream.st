as yet unclassified
validSocketStream
	socketStream ifNotNil: [ ^ socketStream ].
	socketStream := SocketStream on: self validSocket.
	^ socketStream