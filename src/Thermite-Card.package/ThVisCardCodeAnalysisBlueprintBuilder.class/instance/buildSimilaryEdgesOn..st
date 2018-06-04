visualization
buildSimilaryEdgesOn: builder
	| elements edges |
	similarityGroups do: [ :g |
		elements := builder view elementsFromModels: g.
		builder edges shape color: Color transparent.
		edges := builder edges
			elements: elements;
			useAssociations: (g allButFirst collect: [:t | g first -> t]).
		self displayEdges: edges forElements: elements
	]
