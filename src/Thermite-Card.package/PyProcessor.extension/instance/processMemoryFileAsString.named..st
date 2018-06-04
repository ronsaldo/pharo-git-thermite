*Thermite-Card
processMemoryFileAsString: fileContentAsString named: filename
	| f |
	f := ThVisPyMemoryFile new.
	f filename: filename.
	f initializeFromContentAsString: fileContentAsString.
	filesAsDictionary at: f baseFilename put: f