world menu
menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: #'Please, provide Feedback')
			order: 2.0; 
			parent: self projectName asSymbol;
			label: 'Please, provide Feedback';
			action: [ WebBrowser openOn: 'https://docs.google.com/forms/d/e/1FAIpQLSeir6VlE3bR78oRsNAp9eHLkUn2Q016wEliOJN7tFlTmYFi8w/viewform?usp=sf_link' ]