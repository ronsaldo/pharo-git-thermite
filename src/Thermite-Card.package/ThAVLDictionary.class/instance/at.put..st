accessing
at: aKey put: aValue
	| n |
	n := self nodeAt: aKey ifAbsentPut: [ nil ].
	n value: aValue.
	^ aValue