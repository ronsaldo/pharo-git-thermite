as yet unclassified
commitLogCommand
	^ 'git --no-pager log --pretty=oneline -1 {1}' format: { name }