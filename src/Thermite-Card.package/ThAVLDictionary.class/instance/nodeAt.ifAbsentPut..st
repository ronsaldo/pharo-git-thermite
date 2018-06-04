accessing
nodeAt: aKey ifAbsentPut: aBlock
	| position result |
	root ifNil: [
		size := size + 1.
		^ root := ThAVLDictionaryNode new
			key: aKey;
			value: aBlock value;
			yourself.
	].

	position := root.
	[
		position key = aKey ifTrue: [ ^ position ].
		aKey < position key ifTrue: [
			position left ifNil: [
				size := size + 1.
				result := ThAVLDictionaryNode new
					key: aKey;
					value: aBlock value;
					yourself.
				position left: result.
				self rebalanceFrom: result.
				^ result
			] ifNotNil: [
				position := position left
			]
		] ifFalse: [ 
			position right ifNil: [
				size := size + 1.
				result := ThAVLDictionaryNode new
					key: aKey;
					value: aBlock value;
					yourself.
				position right: result.
				self rebalanceFrom: result.
				^ result
			] ifNotNil: [
				position := position right
			]
		]
	] repeat