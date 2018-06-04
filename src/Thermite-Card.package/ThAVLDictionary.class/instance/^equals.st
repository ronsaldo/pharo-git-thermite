comparing
= other
	| left right |
	self class ~~ other class ifTrue: [ ^ false ].
	left := self begin.
	right := other begin.
	[ left isNil or: [right isNil] ] whileFalse: [ 
		(left key = right key and: [ left value = right value ]) ifFalse: [ ^ false ].
		left := left next.
		right := right next.
	].

	^ left isNil and: [right isNil]