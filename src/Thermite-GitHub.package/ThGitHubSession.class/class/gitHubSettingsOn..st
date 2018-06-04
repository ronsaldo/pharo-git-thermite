as yet unclassified
gitHubSettingsOn: aBuilder
	<systemsettings>
	(aBuilder group: #githubApi)
		label: 'GitHub';
		description: 'GitHub related settings';
		with: [
			(aBuilder setting: #gitHubMainUserName)
				label: 'Main User Name';
				target: self;
				getSelector: #mainUserName;
				setSelector: #mainUserName:.
		
			(aBuilder setting: #gitHubMainUserAccessToken)
				label: 'Main User Access Token';
				target: self;
				getSelector: #mainUserAccessToken;
				setSelector: #mainUserAccessToken:.
				
		]