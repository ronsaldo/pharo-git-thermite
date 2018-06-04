comparing
hash
	| result position |
	result := self class identityHash.
	position := self begin.
	[ position isNotNil ] whileTrue: [ 
		result := result bitXor: position key hash.
		result := result bitXor: position value hash.
		position := position next
	].
	^ result