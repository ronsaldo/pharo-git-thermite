ui
diff
	^ diff ifNil: [diff := (TextDiffBuilder from: self oldSource to: self newSource) buildDisplayPatch]