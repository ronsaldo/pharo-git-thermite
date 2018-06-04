testing
checkForChildModification
	children valuesDo: [ :child | child wasModified ifTrue: [ ^ true ] ].
	^ false