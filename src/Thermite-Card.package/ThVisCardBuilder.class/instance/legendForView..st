as yet unclassified
legendForView: aView
	| lb |
	lb := RTLegendBuilder new.
	aView ifNotNil: [ lb view: aView ].
	
	lb addText: 'Legend'.
	lb addColor: self palette unchangedColor text: 'Unchanged'.
	lb addColor: self palette additionsColor text: 'Additions'.
	lb addColor: self palette deletionsColor text: 'Deletions'.
	lb addColor: self palette modifiedColor text: 'Modified'.
	lb addColor: self palette movementColor text: 'Moved/Renamed'.
	^ lb build