printing
printOn: aStream
	aStream nextPutAll: self class name; nextPutAll: ' data: '; print: data