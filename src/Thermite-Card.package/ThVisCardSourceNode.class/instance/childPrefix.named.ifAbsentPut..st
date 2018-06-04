accessing
childPrefix: prefix named: childName ifAbsentPut: aBlock 
	^ children at: prefix , childName ifAbsent: [
		| result |
		result := aBlock value.
		result parent: self.
		children at: prefix , result name put: result.
		result 
	]