Class {
	#name : #ThVisCardColorPalette,
	#superclass : #Object,
	#instVars : [
		'visitCardBackground',
		'unchangedColor',
		'additionsColor',
		'deletionsColor',
		'mergeablePullRequestColor',
		'unmergablePullRequestColor',
		'mergeabilityUnknownColor',
		'testFileColor',
		'normalFileColor',
		'classMovementRefactorInteriorColor',
		'classInteriorColor',
		'classHierarchyUnchangedColor',
		'testNodeBorderdColor',
		'normalNodeBorderColor',
		'movementColor',
		'leafUnchangedColor',
		'modifiedColor',
		'viewBackground',
		'metricPlotBackground',
		'filesBackground',
		'packageBackground',
		'textColor',
		'importantTextColor',
		'nodeModifiedColor',
		'popupBackgroundColor',
		'stackBarLabelColor',
		'packagePanelTitleColor'
	],
	#category : #'Thermite-Card-CodeAnalysis'
}

{ #category : #accessing }
ThVisCardColorPalette class >> default [
	^ self new
]

{ #category : #accessing }
ThVisCardColorPalette >> additionsColor [
	^ additionsColor
]

{ #category : #accessing }
ThVisCardColorPalette >> additionsColor: anObject [
	additionsColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> classHierarchyUnchangedColor [
	^ classHierarchyUnchangedColor
]

{ #category : #accessing }
ThVisCardColorPalette >> classHierarchyUnchangedColor: anObject [
	classHierarchyUnchangedColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> classInteriorColor [
	^ classInteriorColor
]

{ #category : #accessing }
ThVisCardColorPalette >> classInteriorColor: anObject [
	classInteriorColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> classMovementRefactorInteriorColor [
	^ classMovementRefactorInteriorColor
]

{ #category : #accessing }
ThVisCardColorPalette >> classMovementRefactorInteriorColor: anObject [
	classMovementRefactorInteriorColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> deletionsColor [
	^ deletionsColor
]

{ #category : #accessing }
ThVisCardColorPalette >> deletionsColor: anObject [
	deletionsColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> filesBackground [
	^ filesBackground
]

{ #category : #accessing }
ThVisCardColorPalette >> filesBackground: anObject [
	filesBackground := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> importantTextColor [
	^ importantTextColor
]

{ #category : #accessing }
ThVisCardColorPalette >> importantTextColor: anObject [
	importantTextColor := anObject
]

{ #category : #initialization }
ThVisCardColorPalette >> initialize [
	super initialize.
	self modifiedPalette
]

{ #category : #accessing }
ThVisCardColorPalette >> leafUnchangedColor [
	^ leafUnchangedColor
]

{ #category : #accessing }
ThVisCardColorPalette >> leafUnchangedColor: anObject [
	leafUnchangedColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> mergeabilityUnknownColor [
	^ mergeabilityUnknownColor
]

{ #category : #accessing }
ThVisCardColorPalette >> mergeabilityUnknownColor: anObject [
	mergeabilityUnknownColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> mergeablePullRequestColor [
	^ mergeablePullRequestColor
]

{ #category : #accessing }
ThVisCardColorPalette >> mergeablePullRequestColor: anObject [
	mergeablePullRequestColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> metricPlotBackground [
	^ metricPlotBackground
]

{ #category : #accessing }
ThVisCardColorPalette >> metricPlotBackground: anObject [
	metricPlotBackground := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> modifiedColor [
	^ modifiedColor
]

{ #category : #accessing }
ThVisCardColorPalette >> modifiedColor: anObject [
	modifiedColor := anObject
]

{ #category : #initialization }
ThVisCardColorPalette >> modifiedPalette [
	| red green movementBlue yellow |
	red := Color fromHexString: 'e41a1c'.
	green := Color fromHexString: '169513'.
	movementBlue := Color fromHexString: '9ac6e0'.
	yellow := Color fromHexString: 'efef00'.
	
	textColor := Color black lighter.
	importantTextColor := Color black.
	packagePanelTitleColor := Color darkGray.
	stackBarLabelColor := Color darkGray.
	
	viewBackground := Color white.
	visitCardBackground := Color veryVeryLightGray lighter.
	metricPlotBackground := Color veryLightGray muchLighter.
	filesBackground := Color white.
	packageBackground := Color white.
	
	unchangedColor := Color gray muchLighter.
	leafUnchangedColor := unchangedColor muchLighter.
	additionsColor := green.
	deletionsColor := red.
	modifiedColor := yellow.
	movementColor := movementBlue.
	nodeModifiedColor := Color white.
	
	mergeablePullRequestColor := green.
	unmergablePullRequestColor := Color orange.
	mergeabilityUnknownColor := Color darkGray.

	testFileColor := Color green muchDarker.
	normalFileColor := Color gray.
	
	classMovementRefactorInteriorColor := movementBlue.
	classInteriorColor := Color white.
	classHierarchyUnchangedColor := Color blue.
	
	testNodeBorderdColor := testFileColor.
	normalNodeBorderColor := Color gray.
	popupBackgroundColor := Color white.
]

{ #category : #accessing }
ThVisCardColorPalette >> movementColor [
	^ movementColor
]

{ #category : #accessing }
ThVisCardColorPalette >> movementColor: anObject [
	movementColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> nodeModifiedColor [
	^ nodeModifiedColor
]

{ #category : #accessing }
ThVisCardColorPalette >> nodeModifiedColor: aColor [
	nodeModifiedColor := aColor
]

{ #category : #accessing }
ThVisCardColorPalette >> normalFileColor [
	^ normalFileColor
]

{ #category : #accessing }
ThVisCardColorPalette >> normalFileColor: anObject [
	normalFileColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> normalNodeBorderColor [
	^ normalNodeBorderColor
]

{ #category : #accessing }
ThVisCardColorPalette >> normalNodeBorderColor: anObject [
	normalNodeBorderColor := anObject
]

{ #category : #initialization }
ThVisCardColorPalette >> originalPalette [
	textColor := Color veryDarkGray.
	importantTextColor := Color black.
	
	viewBackground := Color white.
	visitCardBackground := Color veryVeryLightGray lighter.
	metricPlotBackground := Color veryLightGray muchLighter.
	filesBackground := Color veryLightGray lighter.
	packageBackground := Color veryLightGray.
	
	unchangedColor := Color lightGray.
	leafUnchangedColor := unchangedColor muchLighter.
	additionsColor := Color green.
	deletionsColor := Color red.
	modifiedColor := Color yellow.
	movementColor := Color blue.
	
	mergeablePullRequestColor := Color green.
	unmergablePullRequestColor := Color orange.
	mergeabilityUnknownColor := Color darkGray.

	testFileColor := Color green muchDarker.
	normalFileColor := Color gray.
	
	classMovementRefactorInteriorColor := Color blue lighter lighter.
	classInteriorColor := Color lightGray muchLighter.
	classHierarchyUnchangedColor := Color blue.
	
	testNodeBorderdColor := testFileColor.
	normalNodeBorderColor := Color black.

]

{ #category : #accessing }
ThVisCardColorPalette >> packageBackground [
	^ packageBackground
]

{ #category : #accessing }
ThVisCardColorPalette >> packageBackground: anObject [
	packageBackground := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> packagePanelTitleColor [
	^ packagePanelTitleColor
]

{ #category : #accessing }
ThVisCardColorPalette >> packagePanelTitleColor: anObject [
	packagePanelTitleColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> popupBackgroundColor [
	^ popupBackgroundColor
]

{ #category : #accessing }
ThVisCardColorPalette >> popupBackgroundColor: anObject [
	popupBackgroundColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> stackBarLabelColor [
	^ stackBarLabelColor
]

{ #category : #accessing }
ThVisCardColorPalette >> stackBarLabelColor: anObject [
	stackBarLabelColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> testFileColor [
	^ testFileColor
]

{ #category : #accessing }
ThVisCardColorPalette >> testFileColor: anObject [
	testFileColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> testNodeBorderdColor [
	^ testNodeBorderdColor
]

{ #category : #accessing }
ThVisCardColorPalette >> testNodeBorderdColor: anObject [
	testNodeBorderdColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> textColor [
	^ textColor
]

{ #category : #accessing }
ThVisCardColorPalette >> textColor: anObject [
	textColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> unchangedColor [
	^ unchangedColor
]

{ #category : #accessing }
ThVisCardColorPalette >> unchangedColor: anObject [
	unchangedColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> unmergablePullRequestColor [
	^ unmergablePullRequestColor
]

{ #category : #accessing }
ThVisCardColorPalette >> unmergablePullRequestColor: anObject [
	unmergablePullRequestColor := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> viewBackground [
	^ viewBackground
]

{ #category : #accessing }
ThVisCardColorPalette >> viewBackground: anObject [
	viewBackground := anObject
]

{ #category : #accessing }
ThVisCardColorPalette >> visitCardBackground [
	^ visitCardBackground
]

{ #category : #accessing }
ThVisCardColorPalette >> visitCardBackground: anObject [
	visitCardBackground := anObject
]
