gt inspect
gtInspectorCodeChangesViewIn: composite
	<gtInspectorPresentationOrder: -8>
	codeAnalyzer ifNil: [ ^ self ].
	^ codeAnalyzer gtInspectorCodeChangesViewIn: composite