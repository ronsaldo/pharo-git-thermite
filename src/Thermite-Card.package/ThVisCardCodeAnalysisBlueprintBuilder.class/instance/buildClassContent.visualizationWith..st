visualization
buildClassContent: class visualizationWith: builder
	| children |
	children := class children.
	onlyModifiedFunctions ifTrue: [
		children := children reject: [:child | child isFunction and: [child wasModified not or: [ child shouldBeFiltered ]]].
	].

	children := children sorted: [:a :b | a name < b name ].
	self buildLeafTextNodes: children visualizationWith: builder.