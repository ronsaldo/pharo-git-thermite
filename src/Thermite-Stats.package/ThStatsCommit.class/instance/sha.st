git commands
sha
	^ sha ifNil: [ sha := (self repository executeGitCommandOutput: self getHashCommand) ]