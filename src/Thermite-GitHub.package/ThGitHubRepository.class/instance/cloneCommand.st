git commands
cloneCommand
	^ 'git clone ' , self cloneUrl , ' "', self clonePath , '"'