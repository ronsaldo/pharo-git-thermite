accessing
getFileContent: filename ifAbsent: aBlock
	| fullReference |
	fullReference := self cloneFileReference resolve: filename asFileReference.
	^ fullReference exists ifTrue: [ fullReference contents ] ifFalse: [ aBlock value ]