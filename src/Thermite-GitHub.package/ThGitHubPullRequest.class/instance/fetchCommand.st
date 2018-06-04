git commands
fetchCommand
	^ 'git fetch origin ' , self remoteHeadBranchName , ':' , self localHeadBranchName