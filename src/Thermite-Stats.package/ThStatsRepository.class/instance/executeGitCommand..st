git commands
executeGitCommand: command
	OSSUnixSubprocess new
		workingDirectory: self clonePath;
		shellCommand: command;
		runAndWaitOnExitDo: [ :process :outString :errString |
	]