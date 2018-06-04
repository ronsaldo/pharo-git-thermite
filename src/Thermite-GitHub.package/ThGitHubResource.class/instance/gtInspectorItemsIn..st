gt-inspector-extension
gtInspectorItemsIn: composite
	<gtInspectorPresentationOrder: 9> 
	json ifNil: [ ^ nil ].
	^ json gtInspectorItemsIn: composite