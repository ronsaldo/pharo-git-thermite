*Thermite-Card
thermiteChanges
	"Open a patch morph for the changes."
	| newVersionSnapshot oldVersionSnapshot |
	newVersionSnapshot := self version completeSnapshot.
	oldVersionSnapshot := self version completePackageSnapshot.
	
	^ self thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot