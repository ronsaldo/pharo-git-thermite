git commands
doGetDiff
	^ ThGitHubDiffColorizer colorize: (self repository executeGitCommandOutput: self diffCommand)