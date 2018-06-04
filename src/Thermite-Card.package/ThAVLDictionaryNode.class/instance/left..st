accessing
left: anObject
	left := anObject.
	left ifNotNil: [ left parent: self ]