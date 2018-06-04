accessing
diff
	^ diff ifNil: [ diff := self doGetDiff ]