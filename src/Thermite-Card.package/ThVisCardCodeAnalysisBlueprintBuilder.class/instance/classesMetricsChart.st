visualization
classesMetricsChart
	| addedClasses removedClasses movedClasses modifiedClasses unchangedClasses counted allClasses |
	allClasses := OrderedCollection new.
	addedClasses := OrderedCollection new.
	removedClasses := OrderedCollection new.
	movedClasses := OrderedCollection new.
	modifiedClasses := OrderedCollection new.
	unchangedClasses := OrderedCollection new.
	
	sourceRootNode allChildrenDo: [ :node |
		node isClass ifTrue: [
			counted := false.
			node hasMovementRefactor ifTrue: [
				counted := true.
				movedClasses add: node
			] ifFalse: [
				node wasAdded ifTrue: [ addedClasses add: node. counted := true ].
				node wasRemoved ifTrue: [ removedClasses add: node. counted := true ].
				node wasInternallyModified ifTrue: [ modifiedClasses add: node. counted := true ].
				counted ifFalse: [
					onlyModifiedClasses ifFalse: [ 
						unchangedClasses add: node
					]
				]
			].
		
			(onlyModifiedClasses not or: [counted ]) ifTrue: [ allClasses add: node ]
		].
	].

	allClasses ifNotEmpty: [ 
		cardBuilder addNavigation: 'Classes' view: (self visualizationForClasses: allClasses)
	].

	^ self plotMetrics: {
		{ self palette additionsColor . '{1} - Added classes' . addedClasses size . self visualizationForClasses: addedClasses }.
		{ self palette deletionsColor . '{1} - Removed classes' . removedClasses size . self visualizationForClasses: removedClasses }.
		{ self palette movementColor . '{1} - Moved classes' . movedClasses size . self visualizationForClasses: movedClasses }.
		{ self palette modifiedColor . '{1} - Modified classes' . modifiedClasses size . self visualizationForClasses: modifiedClasses }.
		{ self palette unchangedColor . '{1} - Unchanged classes ' . unchangedClasses size . self visualizationForClasses: unchangedClasses }
	} title: 'Classes'.