testing
checkForModification
	^ self oldSource trimBoth ~= self newSource trimBoth or: [ self checkForChildModification ]