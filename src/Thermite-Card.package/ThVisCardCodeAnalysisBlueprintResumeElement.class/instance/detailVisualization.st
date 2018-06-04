ui
detailVisualization
	value ifNil: [ ^ nil ].
	value size < 4 ifTrue: [ ^ nil ].
	^ value fourth