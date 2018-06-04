accessing
addCommit: commit
	self flag: 'FIXME: hack for supporting local repositories'.
	self addPullRequest: commit