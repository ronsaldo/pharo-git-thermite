git commands
getHashCommand
	^ 'git --no-pager log --format=%H -n 1 ' , self name