ui
oldVersionLineCount
	^ oldVersionLineCount ifNil: [ oldVersionLineCount := self countLines: self oldContent ]