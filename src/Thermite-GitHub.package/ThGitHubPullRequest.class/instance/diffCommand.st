git commands
diffCommand
	^ 'git --no-pager diff ' , self parentSha , ' ' , self localHeadBranchName 