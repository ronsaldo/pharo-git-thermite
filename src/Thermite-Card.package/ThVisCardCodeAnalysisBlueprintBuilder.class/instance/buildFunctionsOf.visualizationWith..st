visualization
buildFunctionsOf: root visualizationWith: b
	| children |
	children := root children.
	onlyModifiedFunctions ifTrue: [ 
		children := children reject: [:child | child isFunction and: [child wasModified not]].
	].
	self buildFunctions: (children select: #isFunction) visualizationWith: b