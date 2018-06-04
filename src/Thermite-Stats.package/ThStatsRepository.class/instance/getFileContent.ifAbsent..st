accessing
getFileContent: filename ifAbsent: aBlock
	| fullReference |
	fullReference := path resolve: filename asFileReference.
	^ fullReference exists ifTrue: [ fullReference contents ] ifFalse: [ aBlock value ]