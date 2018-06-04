rotations
rotateLeftLeftParent: parent child: child

	| top left right first second third fourth |
	top := child.
	left := child left.
	right := parent.
	
	first := child left left.
	second := child left right.
	third := child right.
	fourth := parent right.
	
	top left: left.
	top right: right.

	left left: first.
	left right: second.
	right left: third.
	right right: fourth.
		
	left updateHeight.
	right updateHeight.
	top updateHeight.
	^ top