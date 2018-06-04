adding
addPullRequest: pullRequest
	| visitCardElement upperPanel middlePanel visitCard mainPanels lowerPanel |
	pullRequests add: pullRequest.
	visitCard := ThVisCard new pullRequest: pullRequest.
	view canvas color: self palette viewBackground.
	currentVisitCard := visitCard.
	visitCard commits: pullRequest commits allItems.
	visitCard treeView: [self buildCommitTreeViewFor: visitCard].
	
	visitCardElement := RTBox new color: self palette visitCardBackground; elementOn: visitCard.
	visitCardElement @ RTDraggable.
	view add: visitCardElement.

	upperPanel := self buildUpperPanelFor: visitCard.
	middlePanel := self buildMiddlePanelFor: visitCard.

	self flag: 'Improve the commit tree'.
	"self addNavigation: 'Commit Tree' view: [self buildCommitTreeViewFor: visitCard] priority: 11."
	self addNavigation: 'Diff' text: [ pullRequest diff ] priority: 10.
	 
	lowerPanel := self buildLowerPanelFor: visitCard.
	mainPanels := { upperPanel . middlePanel . lowerPanel} select: #isNotNil.

	RTVerticalLineLayout new center; on: mainPanels.

	RTNest new
        on: visitCardElement nest: mainPanels.
	visitCards add: visitCardElement.
	^ visitCardElement