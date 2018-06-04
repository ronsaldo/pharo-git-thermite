accessing
at: aKey
	| n |
	n := self nodeAt: aKey.
	n ifNil: [ self error: 'Key not found in the dictionary' ].
	^ n value