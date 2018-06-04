git commands
parentMessage
	^ parentMessage ifNil: [ parentMessage := (self repository executeGitCommandOutput: self getParentMessageCommand) ]