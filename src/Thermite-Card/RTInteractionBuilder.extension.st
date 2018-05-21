Extension { #name : #RTInteractionBuilder }

{ #category : #'*Thermite-Card' }
RTInteractionBuilder >> popupText: aBlock solidBackgroundColor: aColorBlock [
	self addExclusiveInteraction: (RTPopup new text: aBlock; alphaPopupBackground: 1.0; backgroundColor: aColorBlock)
]
