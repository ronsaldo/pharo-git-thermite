*Thermite-Card
parentChanges
	"Open a patch morph for the changes."
	| oldVersion oldVersionSnapshot newVersionSnapshot ancestor |
	ancestor := self pickAncestor.
	ancestor ifNil: [ ^ self ].
	
	oldVersion := self versionFromVersionInfo: ancestor.
	oldVersionSnapshot := oldVersion completeSnapshot.
	newVersionSnapshot := self version completeSnapshot.
	
	self
		viewChanges: (newVersionSnapshot patchRelativeToBase: oldVersionSnapshot)
		from: oldVersion info name
		to: self version info name