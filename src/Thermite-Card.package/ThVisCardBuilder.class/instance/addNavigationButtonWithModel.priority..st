adding
addNavigationButtonWithModel: aModel priority: priority
	| button background label enterAction leaveAction normalColor highlightColor |
	normalColor := Color veryLightGray.
	highlightColor := Color blue muchLighter.
	background := (RTBox new color: normalColor) elementOn: aModel.
	label := RTLabel new
		text: #label;
		color: self palette textColor;
		elementOn: aModel.
	enterAction := [ :ev |
		background color: highlightColor.
		ev signalUpdate
	].
	leaveAction := [ :ev |
		background color: normalColor.
		ev signalUpdate
	].

	label when: TRMouseEnter do: enterAction.
	label when: TRMouseLeave do: leaveAction.

	RTNest new on: background nest: { label }.
	button := { background . { background . label } . priority }.
	
	navigationButtons := navigationButtons , { button }