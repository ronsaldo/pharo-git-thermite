initialization
indexForToken: aToken
	^ dictionary at: aToken ifAbsentPut: [ dictionary size + 1 ]