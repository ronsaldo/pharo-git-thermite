testing
wasModified
	^ wasModified ifNil: [ wasModified := self checkForModification ]