git commands
cloneRepo
	self cloneFileReference exists ifTrue: [ ^ true ].
	OSSUnixSubprocess new
		shellCommand: self cloneCommand;
		runAndWaitOnExitDo: [ :process :outString :errString |
	].
	FileStream stdout nextPutAll: 'Clone done.'; lf.