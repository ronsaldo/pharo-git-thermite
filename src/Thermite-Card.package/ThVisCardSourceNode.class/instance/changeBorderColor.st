visualization
changeBorderColor
	self wasAdded ifTrue: [ ^ self palette additionsColor ].
	self wasRemoved ifTrue: [ ^ self palette deletionsColor ].
	^ self wasModified ifTrue: [ self palette modifiedColor ] ifFalse: [ self palette normalNodeBorderColor ]