git commands
executeGitCommandOutput: command
	OSSUnixSubprocess new
		workingDirectory: self clonePath;
		shellCommand: command;
		redirectStdout;
		redirectStderr;
		runAndWaitPollingEvery: (Delay forMilliseconds: 20) retrievingStreams: true onExitDo: [ :process :outString :errString |
			^ outString
	]