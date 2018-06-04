monticello
mcDiff
	| packages packageDictionary old new patchOperations patch |
	packages := self loadOldAndNewMonticelloPackageSnapshots.
	packageDictionary := Dictionary new.
	packages first do: [ :versionSnapshot |
		(packageDictionary at: versionSnapshot first info name ifAbsentPut: [{nil . nil}]) at: 1 put: versionSnapshot second
	].
	packages second do: [ :versionSnapshot |
		(packageDictionary at: versionSnapshot first info name ifAbsentPut: [{nil . nil}]) at: 2 put: versionSnapshot second
	].

	"
	packageDictionary keysAndValuesDo: [ :packageName :changedPackage |
		old := changedPackage first ifNil: [MCSnapshot empty].
		new := changedPackage second ifNil: [MCSnapshot empty].
			MCVersionInspector new viewChanges: (new patchRelativeToBase: old)
		from: ('[{1}] {2}' format: {packageName . self name})
		to: self parentName
	].
	"
	
	patchOperations := OrderedCollection new.
	packageDictionary keysAndValuesDo: [ :packageName :changedPackage |
		old := changedPackage first ifNil: [MCSnapshot empty].
		new := changedPackage second ifNil: [MCSnapshot empty].
		patchOperations addAll: (new patchRelativeToBase: old) operations
	].
	
	patch := MCPatch operations: patchOperations.
	MCVersionInspector new viewChanges: patch
		from: self name
		to: self parentName