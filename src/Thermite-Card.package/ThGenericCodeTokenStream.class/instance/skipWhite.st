accessing
skipWhite
	[in atEnd not and: [in peek <= Character space]] whileTrue: [ in next ]