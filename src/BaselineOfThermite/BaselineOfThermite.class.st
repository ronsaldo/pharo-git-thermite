Class {
	#name : #BaselineOfThermite,
	#superclass : #BaselineOf,
	#category : 'BaselineOfThermite'
}

{ #category : #baselines }
BaselineOfThermite >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec configuration: 'OSSubprocess' with: [
			spec
				versionString: #stable;
				repository: 'github://marianopeck/OSSubprocess/repository' ];
			yourself.

		spec
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://mc.stfx.eu/Neo' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'development';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ];
			project: 'Roassal2' with: [
				spec
					className: #ConfigurationOfRoassal2;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ].
		spec package: 'DataStudio' with: [
			spec
				requires: #('Roassal2');
				repository: 'http://smalltalkhub.com/mc/ObjectProfile/DataStudio/main/'].
		spec package: 'DataStudio-PythonAnalyzer' with: [
			spec
				requires: #('DataStudio');
				repository: 'http://smalltalkhub.com/mc/ObjectProfile/DataStudio/main/'].
		spec 
			package: #'Thermite-GitHub' with: [
				spec requires: #('NeoJSON' 'PetitParser' 'OSSubprocess').
			];
			package: #'Thermite-Stats' with: [
				spec requires: #('Thermite-GitHub')
			];
			package: #'Thermite-Card' with: [ 
				spec requires: #('Thermite-Stats' 'DataStudio-PythonAnalyzer')
			]
	]

]
