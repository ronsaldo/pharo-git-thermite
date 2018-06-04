accessing
right: anObject
	right := anObject.
	right ifNotNil: [ right parent: self ]