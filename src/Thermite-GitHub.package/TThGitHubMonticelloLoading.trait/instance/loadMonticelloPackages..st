monticello
loadMonticelloPackages: packages
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