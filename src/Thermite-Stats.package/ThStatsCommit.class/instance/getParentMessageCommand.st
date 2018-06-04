git commands
getParentMessageCommand
	^ 'git --no-pager log --format=%B -n 1 ' , self parentName