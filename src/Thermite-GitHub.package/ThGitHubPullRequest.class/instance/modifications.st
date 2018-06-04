modifications
modifications
	^ modifications ifNil: [ modifications := self doFindModifications ]