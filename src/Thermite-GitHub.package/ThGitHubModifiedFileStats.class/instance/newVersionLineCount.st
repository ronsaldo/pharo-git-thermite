ui
newVersionLineCount
	^ newVersionLineCount ifNil: [ newVersionLineCount := self countLines: self newContent ]