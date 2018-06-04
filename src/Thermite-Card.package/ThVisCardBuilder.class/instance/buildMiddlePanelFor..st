as yet unclassified
buildMiddlePanelFor: visitCard
	| panel panelElements pullRequest structureLabel charts chartsPanel |
	pullRequest := visitCard pullRequest.
	panel := RTBox element.

	panelElements := #().
	structureLabel :=	(self label: 'Metrics') element.
	view add: structureLabel.
	
	chartsPanel := (RTBox 
		color: Color transparent) element.
	view add: chartsPanel.

	charts := self buildFileChangesChartFor: pullRequest.
	charts := charts ,	(self buildCodeChangesFor: pullRequest).
	charts := charts select: #isNotNil.
	useStackBarPlot ifTrue: [ 
		RTVerticalLineLayout on: charts.
	] ifFalse: [ 
		RTGridLayout on: charts.
	].
	
	RTNest new
        on: chartsPanel nestRootOf: charts.

	panelElements := panelElements , {
		structureLabel .
		chartsPanel
	}.
	
	self addNavigation: 'Code Changes' view: codeAnalyzer codeChangesViewBlock priority: -9.
	RTVerticalLineLayout on: panelElements.
	
	RTNest new
        on: panel nest: panelElements.
	^ panel