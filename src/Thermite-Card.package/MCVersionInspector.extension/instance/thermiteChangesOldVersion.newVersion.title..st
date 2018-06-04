*Thermite-Card
thermiteChangesOldVersion: oldVersionSnapshot newVersion: newVersionSnapshot title: title
	"Open a patch morph for the changes."
	| packageName builder analyzer |
	packageName := self version package name.
	
	builder := ThVisCardBuilder new.
	builder withoutUnchangedLines.
	analyzer := builder pharoCodeAnalyzer.
	analyzer allContent;
		withoutUnchangedLines;
		onlyModifiedFunctions ;
		onlyModifiedClasses.
				
	builder
		addMonticelloPackage: packageName
			from: oldVersionSnapshot to: newVersionSnapshot
			title: title;
		vertical;
		inspect
