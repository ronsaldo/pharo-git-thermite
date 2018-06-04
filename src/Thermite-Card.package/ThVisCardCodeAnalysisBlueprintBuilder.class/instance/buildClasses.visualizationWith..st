visualization
buildClasses: nodes visualizationWith: b
	| classes classDictionary |
	b interaction 
		noInteractions;
		popupText: #description solidBackgroundColor: self palette popupBackgroundColor.
	b shape rectangle
		withTextBelow: #name;
		borderColor: #changeBorderColor;
		borderWidth: 3;
		color: [:n | n hasMovementRefactor
				ifTrue: [self palette classMovementRefactorInteriorColor ]
				ifFalse: [self palette classInteriorColor]].
	b shape shape allShapes second color: [ self palette textColor ].
	classes := nodes select: #isClass.

	b nodes: classes forEach: [:class |
		self buildClassContent: class visualizationWith: b
	].

	classDictionary := Dictionary new.
	classes do: [ :cls | classDictionary at: cls name put: cls ].

	b shape orthoVerticalLine color: self palette deletionsColor.
	b edges
		connectFrom: [ :cls | cls unchangedSuperName ifNil: [classDictionary at: cls oldSuperName ifAbsent: [ nil ] ] ifNotNil: [ nil ] ].

	b shape orthoVerticalLine color: self palette classHierarchyUnchangedColor.
	b edges
		connectFrom: [ :cls | classDictionary at: cls unchangedSuperName ifAbsent: [ nil ] ].

	b shape orthoVerticalLine color: self palette additionsColor.
	b edges
		connectFrom: [ :cls | cls unchangedSuperName ifNil: [classDictionary at: cls newSuperName ifAbsent: [ nil ] ] ifNotNil: [ nil ] ].
