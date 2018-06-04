visualization
methodsMetricsChart
	|  addedMethods removedMethods movedMethods modifiedMethods unchangedMethods counted allMethods |
	addedMethods := OrderedCollection new.
	removedMethods := OrderedCollection new.
	modifiedMethods := OrderedCollection new.
	movedMethods := OrderedCollection new.
	unchangedMethods := OrderedCollection new.
	allMethods := OrderedCollection new.
	
	sourceRootNode allChildrenDo: [ :node |
		self flag: 'TODO: Check this filtering'.
		node isFunction ifTrue: [
			counted := false.
			node hasMovementRefactor ifTrue: [
				counted := true.
				node shouldBeCountedAsMovement ifTrue: [
					movedMethods add: node.
				]
			] ifFalse: [ 
				node wasAdded ifTrue: [ addedMethods add: node . counted := true ].
				node wasRemoved ifTrue: [ removedMethods add: node . counted := true ].
			].
			node wasInternallyModified ifTrue: [ modifiedMethods add: node . counted := true ].
			
			counted ifFalse: [
				onlyModifiedFunctions ifFalse: [
					unchangedMethods add: node
				]
			].
		
			(onlyModifiedFunctions not or: [ counted ]) ifTrue: [ allMethods add: node ]
		].
	].

	allMethods ifNotEmpty: [ 
		cardBuilder addNavigation: 'Methods' view: (self visualizationForMethods: allMethods)
	].

	^ self plotMetrics: {
		{ self palette additionsColor . '{1} - Added methods/functions' . addedMethods size . self visualizationForMethods: addedMethods }.
		{ self palette deletionsColor . '{1} - Removed methods/functions' . removedMethods size . self visualizationForMethods: removedMethods }.
		{ self palette movementColor . '{1} - Moved methods/functions' . movedMethods size . self visualizationForMethods: movedMethods }.
		{ self palette modifiedColor . '{1} - Modified methods/functions' . modifiedMethods size . self visualizationForMethods: modifiedMethods }.
		{ self palette unchangedColor . '{1} - Unchanged methods/functions' . unchangedMethods size . self visualizationForMethods: unchangedMethods }.
	} title: 'Methods/Functions'.