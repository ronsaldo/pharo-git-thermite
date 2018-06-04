git commands
getMessageCommand
	^ 'git --no-pager log --format=%B -n 1 ' , self name