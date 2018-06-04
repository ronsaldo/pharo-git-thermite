world menu
menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: (self projectName , ' Visualize Local Commit') asSymbol)
			order: 0.1; 
			parent: self projectName asSymbol;
			label: 'Visualize local commit';
			action: [ self new open ]