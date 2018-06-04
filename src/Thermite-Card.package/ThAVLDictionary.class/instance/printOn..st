printing
printOn: aStream
	aStream nextPutAll: self class name; nextPutAll: ' newFrom: {'; cr.
	self do: [ :node |
		aStream print: node key; nextPutAll: ' -> '; print: node value; nextPutAll: '.'; cr
	].
	aStream nextPutAll: '}'.