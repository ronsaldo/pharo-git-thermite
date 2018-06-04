world menu
menuCommandOn: aBuilder
	<worldMenu>
	((aBuilder item: self projectName asSymbol))
	withSeparatorAfter;
	with: [
		(aBuilder item: (self projectName , ' Examples') asSymbol)
			order: 0.1; 
			parent: self projectName asSymbol;
			label: self projectName , ' examples';
			action: [ self new open ] ]