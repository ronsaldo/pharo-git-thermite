testing
wasInternallyModified
	^ self wasAdded not and: [self wasRemoved not and: [self wasModified]]