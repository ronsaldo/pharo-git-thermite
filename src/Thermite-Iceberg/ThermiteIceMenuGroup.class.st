Class {
	#name : #ThermiteIceMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : #'Thermite-Iceberg-Commander'
}

{ #category : #accessing }
ThermiteIceMenuGroup >> description [
	^'Thermite visualization operations'
]

{ #category : #accessing }
ThermiteIceMenuGroup >> name [
	^'Thermite'
]

{ #category : #accessing }
ThermiteIceMenuGroup >> order [
	"Plugins are SmallInteger maxVal - 2000 .. SmallInteger maxVal"
	^ SmallInteger maxVal - 1600
]
