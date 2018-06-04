accessing
model: aModel old: isOldModel
	isOldModel ifTrue: [ self oldModel: aModel ] ifFalse: [ self newModel: aModel ]