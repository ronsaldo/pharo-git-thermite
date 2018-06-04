accessing
at: index
	| elementUrl |
	elementClass isIndirectArrayElement ifFalse: [
		^ elementClass new
			session: session;
			json: (json at: index);
			parent: parent;
			yourself
	].
	elementUrl := (json at: index) at: 'url'.
	^ session getCachedResource: elementUrl class: elementClass parent: parent