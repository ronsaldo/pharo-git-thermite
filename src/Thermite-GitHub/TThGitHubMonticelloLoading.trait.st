Trait {
	#name : #TThGitHubMonticelloLoading,
	#category : 'Thermite-GitHub'
}

{ #category : #monticello }
TThGitHubMonticelloLoading >> findModifiedMonticelloPackages [
	| re range filetreeRepository packageName result ranges |
	re := '[^/\\]+\.package' asRegex.
	result := Dictionary new.
	self modifiedFilenames do: [ :filename |
		ranges := (re matchingRangesIn: filename).
		ranges ifNotEmpty: [
			range := ranges last.
			filetreeRepository := filename first: range first - 1.
			packageName := filename copyFrom: range first to: range last.
			result at: filetreeRepository , packageName put: { packageName . filetreeRepository } 
		]
	].
	^ result

]

{ #category : #monticello }
TThGitHubMonticelloLoading >> loadMonticelloPackageSnapshots: packages [
	| packageName filetreeRepository filetreeReference repository version |
	^ packages values collect: [ :value |
		packageName := value first.
		filetreeRepository := value second ifEmpty: ['.'].
		filetreeReference := self repository clonePath asFileReference resolve: filetreeRepository.
		filetreeReference exists ifTrue: [ 
			repository := MCFileTreeRepository new directory: filetreeReference.

			version := repository versionFrom: (repository versionNameFromFileName: packageName).
			version ifNotNil: [ 
				{version . version snapshot}
			]
		]
	] thenSelect: #isNotNil
]

{ #category : #monticello }
TThGitHubMonticelloLoading >> loadMonticelloPackages: packages [
	| packageName filetreeRepository filetreeReference repository version |
	^ packages values collect: [ :value |
		packageName := value first.
		filetreeRepository := value second ifEmpty: ['.'].
		filetreeReference := self repository clonePath asFileReference resolve: filetreeRepository.
		filetreeReference exists ifTrue: [ 
			repository := MCFileTreeRepository new directory: filetreeReference.

			version := repository versionFrom: (repository versionNameFromFileName: packageName).
			version ifNotNil: [ 
				version snapshot asRingPackageNamedForThermite: packageName
			]
		]
	] thenSelect: #isNotNil
]

{ #category : #monticello }
TThGitHubMonticelloLoading >> loadOldAndNewMonticelloPackageSnapshots [
	| packages oldVersion newVersion |
	packages := self findModifiedMonticelloPackages.
	self checkoutParent.
	oldVersion := self loadMonticelloPackageSnapshots: packages.
	self checkout.
	newVersion := self loadMonticelloPackageSnapshots: packages.
	
	^ {oldVersion . newVersion}

]

{ #category : #monticello }
TThGitHubMonticelloLoading >> loadOldAndNewMonticelloPackages [
	| packages oldVersion newVersion |
	packages := self findModifiedMonticelloPackages.
	self checkoutParent.
	oldVersion := self loadMonticelloPackages: packages.
	self checkout.
	newVersion := self loadMonticelloPackages: packages.
	
	^ {oldVersion . newVersion}

]

{ #category : #monticello }
TThGitHubMonticelloLoading >> mcDiff [
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
]
