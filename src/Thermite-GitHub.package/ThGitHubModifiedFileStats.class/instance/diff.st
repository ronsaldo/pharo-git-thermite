accessing
diff
	^ diff ifNil: [diff := (TextDiffBuilder from: self oldContent to: self newContent) buildDisplayPatch]