visualization
visualizationForMethods: aCollectionOfMethods
	| builder |
	^ [
		builder := self newMondrianBuilder.
		self buildLeafTextNodes: (aCollectionOfMethods sorted: [ :a :b | a name < b name ]) visualizationWith: builder displayNames: true.
		builder
	]