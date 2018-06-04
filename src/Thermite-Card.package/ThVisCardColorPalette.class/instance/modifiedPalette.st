initialization
modifiedPalette
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