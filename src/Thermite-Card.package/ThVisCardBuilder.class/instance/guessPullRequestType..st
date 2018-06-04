as yet unclassified
guessPullRequestType: pullRequest
	| title |
	title := pullRequest title.
	(title includesSubstring: 'bug' caseSensitive: false) ifTrue: [ ^ 'Bug Fix' ].
	(title includesSubstring: 'enh' caseSensitive: false) ifTrue: [ ^ 'Enhance' ].
	(title includesSubstring: 'feature' caseSensitive: false) ifTrue: [ ^ 'Feature' ].
	(title includesSubstring: 'dep' caseSensitive: false) ifTrue: [ ^ 'Deprecate' ].
	^ ''