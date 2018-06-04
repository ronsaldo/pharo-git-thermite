visualization
changeColor
	self wasAdded ifTrue: [ ^ self palette additionsColor ].
	self wasRemoved ifTrue: [ ^ self palette deletionsColor ].
	^ self wasModified ifTrue: [ self palette nodeModifiedColor ] ifFalse: [ self palette unchangedColor ]