as yet unclassified
loadPackages: packages pullRequest: pullRequest
	| packageName filetreeRepository filetreeReference repository version package elements methodClass |
	^ packages values collect: [ :value |
		packageName := value first.
		filetreeRepository := value second ifEmpty: ['.'].
		filetreeReference := pullRequest repository clonePath asFileReference resolve: filetreeRepository.
		filetreeReference exists ifTrue: [ 
			repository := MCFileTreeRepository new directory: filetreeReference.

			version := repository versionFrom: (repository versionNameFromFileName: packageName).
			version ifNotNil: [ 
				package := RGPackage named: packageName.
				elements := version snapshot definitions collect: #asRingDefinition.
				elements reject: #isOrganization thenDo: [ :element |
					(element isTrait and: [ element isMeta ]) ifFalse: [ 
						package addElement: element
					]
				].
				package methodsDo: [ :method |
					methodClass := package lookupClassNamed: method className.
					methodClass ifNotNil: [ methodClass addMethod: method ]
				].
				package
			]
		]
	] thenSelect: #isNotNil