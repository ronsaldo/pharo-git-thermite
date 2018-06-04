world menu
menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: (self projectName , ' Visualize Pull Request') asSymbol)
			order: 0.1; 
			parent: self projectName asSymbol;
			label: 'Visualize pull request';
			action: [ self new open ]