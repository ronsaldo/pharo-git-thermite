git commands
numStatCommand
	^ 'git --no-pager diff --numstat ' , self parentName, ' ' , self name