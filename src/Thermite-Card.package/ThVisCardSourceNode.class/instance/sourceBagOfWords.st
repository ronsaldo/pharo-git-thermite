accessing
sourceBagOfWords
	^ sourceBagOfWords ifNil: [ oldSourceBagOfWords + newSourceBagOfWords ]