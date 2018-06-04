adding
addPullRequest: pullRequest
	| state |
	state := pullRequest state.
	pullRequests := pullRequests + 1.
	
	state = 'open' ifTrue: [
		openPullRequests := openPullRequests + 1.
	] ifFalse: [ 
		self assert: state = 'closed'.
		pullRequest merged ifTrue: [
			acceptedPullRequests := acceptedPullRequests + 1
		] ifFalse: [
			rejectedPullRequests := rejectedPullRequests + 1
		]
	]
	