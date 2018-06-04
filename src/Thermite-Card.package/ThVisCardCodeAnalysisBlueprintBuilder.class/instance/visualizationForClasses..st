visualization
visualizationForClasses: aCollectionOfClasses
	| builder |
	^ [
		builder := self newMondrianBuilder.
		self buildClasses: (aCollectionOfClasses sorted: [:a :b | a name < b name ]) visualizationWith: builder.
		builder layout tree;
		ifNotConnectedThen: RTGridLayout new.
		builder
	]