visualization
buildClassesOf: root visualizationWith: b
	| children |
	children := root children select: #isClass.
	onlyModifiedClasses ifTrue: [ 
		children := children reject: [:child | child wasModified not].
	].

	self buildClasses: children visualizationWith: b
