*Thermite-Card
thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot
	^ self thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot title: ('Changes from {1} to {2}' format: {self version workingCopy description . self version info name})