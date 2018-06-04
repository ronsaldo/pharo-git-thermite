*Thermite-Card
thermiteParentChanges
	"Open a patch morph for the changes."
	| newVersionSnapshot oldVersionSnapshot oldVersion ancestor |
	ancestor := self pickAncestor.
	ancestor ifNil: [ ^ self ].
	
	oldVersion := self versionFromVersionInfo: ancestor.
	oldVersionSnapshot := oldVersion completeSnapshot.
	newVersionSnapshot := self version completeSnapshot.
	
	^ self thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot
		title: ('Changes from {1} to {2}' format: {oldVersion info name . self version info name})