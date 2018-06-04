git commands
message
	^ message ifNil: [ message := (self repository executeGitCommandOutput: self getMessageCommand) ]