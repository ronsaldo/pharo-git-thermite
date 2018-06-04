printing
printOn: aStream
	^ aStream nextPutAll: filename; nextPutAll: ' Additions: '; print: additions; nextPutAll: ' Deletions: '; print: deletions