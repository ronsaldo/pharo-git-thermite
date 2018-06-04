as yet unclassified
gtInspectorTree: composite
	<gtInspectorPresentationOrder: 10>
	^ composite tree 
		title: 'Tree';
		display: [ :d | root ];
		children: [ :each | each children ];
		format: [ :node | node printString ]