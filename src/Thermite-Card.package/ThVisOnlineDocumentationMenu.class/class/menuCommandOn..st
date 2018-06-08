world menu
menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: #'Online documentation')
			order: 0.001; 
			parent: self projectName asSymbol;
			label: 'Online documentation';
			icon: (Smalltalk ui icons iconNamed: #smallInfo);
			action: [ WebBrowser openOn: 'https://github.com/ronsaldo/pharo-git-thermite' ]