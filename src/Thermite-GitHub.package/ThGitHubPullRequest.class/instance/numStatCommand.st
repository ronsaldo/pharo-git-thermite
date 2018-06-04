git commands
numStatCommand
	^ 'git --no-pager diff --numstat ' , self parentSha , ' ' , self localHeadBranchName 