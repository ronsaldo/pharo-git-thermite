accessing
childNamed: childName ifAbsentPut: aBlock 
	^ children at: childName ifAbsent: [
		| result |
		result := aBlock value.
		result parent: self.
		children at: result name put: result.
		result 
	]