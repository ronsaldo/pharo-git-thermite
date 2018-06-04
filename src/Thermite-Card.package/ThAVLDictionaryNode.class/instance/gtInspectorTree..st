as yet unclassified
gtInspectorTree: composite
	<gtInspectorPresentationOrder: 10>
	^ composite tree 
		title: 'Tree';
		display: [ :d | self ];
		children: [ :each | each children ];
		format: [ :node | node printString ]