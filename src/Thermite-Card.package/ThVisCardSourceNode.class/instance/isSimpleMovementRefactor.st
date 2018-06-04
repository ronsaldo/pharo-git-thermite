testing
isSimpleMovementRefactor
	| addedCount removedCount |
	addedCount := 0.
	removedCount := 0.
	self allMovementRefactorNodesDo: [ :n |
		n wasAdded ifTrue: [
			addedCount := addedCount + 1
		].
		n wasRemoved ifTrue: [
			removedCount := removedCount + 1
		].
	].
	^ addedCount = removedCount