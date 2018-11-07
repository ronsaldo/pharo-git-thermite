Class {
	#name : #ThermiteIceVisualizationSetupBrowser,
	#superclass : #IceTipBrowser,
	#instVars : [
		'targetHistoryPanel',
		'sourceHistoryPanel'
	],
	#category : #'Thermite-Iceberg'
}

{ #category : #'instance creation' }
ThermiteIceVisualizationSetupBrowser class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		newColumn: [ :column |
			column 
				add: #targetHistoryPanel withSpec: #panelSpec left: 0.3;
				addHSplitter;
				add: #sourceHistoryPanel withSpec: #panelSpec left: 0.3]
]

{ #category : #'instance creation' }
ThermiteIceVisualizationSetupBrowser class >> new [
	self error: 'Use #for:'
]

{ #category : #'instance creation' }
ThermiteIceVisualizationSetupBrowser class >> onRepository: aRepository [
	^ self on: (IceTipRepositoryModel on: aRepository)
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> contextClass [
	^ IceTipRepositoryContext
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> initializeWidgets [
	super initializeWidgets.	
	
	targetHistoryPanel := self instantiate: IceTipHistoryBrowser on: self model headModel.
	sourceHistoryPanel := self instantiate: IceTipHistoryBrowser on: self model headModel.

	self focusOrder 
		add: targetHistoryPanel;
		add: sourceHistoryPanel
		
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> sourceHistoryPanel [
	^ sourceHistoryPanel
]

{ #category : #initialization }
ThermiteIceVisualizationSetupBrowser >> targetHistoryPanel [
	^ targetHistoryPanel
]
