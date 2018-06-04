accessing
link: linkString
	(linkString isNil or: [ linkString isEmpty ]) ifTrue: [
		links := EmptyLinks.
	] ifFalse: [
		links := Dictionary new.
		(ThGitHubLinkParser new parse: linkString) do: [ :link |
			links at: (link second at: 'rel') put: link first
		]
	]