accessing
modifications
	^ modifications ifNil: [ modifications := self doFindModifications ]