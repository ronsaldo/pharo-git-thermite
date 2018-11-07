Class {
	#name : #ThermiteIceVisualizeCommand,
	#superclass : #ThermiteIceCommand,
	#category : #'Thermite-Iceberg'
}

{ #category : #accessing }
ThermiteIceVisualizeCommand class >> browserRepositoryListActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ThermiteIceMenuGroup
		for: IceTipRepositoryListContext
]

{ #category : #accessing }
ThermiteIceVisualizeCommand class >> defaultMenuItemName [
	^ 'Create Thermite Visualization...'
]

{ #category : #execution }
ThermiteIceVisualizeCommand >> execute [
	(ThermiteIceVisualizationSetupBrowser on: self repositoryModel) openWithSpec
]
