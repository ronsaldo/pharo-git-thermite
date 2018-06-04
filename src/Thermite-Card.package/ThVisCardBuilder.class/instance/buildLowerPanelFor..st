as yet unclassified
buildLowerPanelFor: visitCard
	| panel panelElements label buttonsPanel buttons |
	navigationButtons ifEmpty: [ ^ nil ].
	navigationButtons sort: [ :a :b | a third <= b third ].
	panel := RTBox element.
	view add: panel.

	label := (self label: 'Visualizations') element.
	view add: label.
	panelElements := {label}.
	
	buttonsPanel := RTBox element.
	view add: buttonsPanel.

	navigationButtons do: [ :but | view addAll: but second ].
	buttons := navigationButtons collect: #first.
	RTHorizontalLineLayout on: buttons.
	"RTGridLayout on: buttons."
	
	RTNest new
        on: buttonsPanel nest: buttons.
	panelElements := panelElements , { buttonsPanel }.
	
	RTVerticalLineLayout on: panelElements.
	
	RTNest new
        on: panel nest: panelElements.

	navigationButtons := #().
	^ panel