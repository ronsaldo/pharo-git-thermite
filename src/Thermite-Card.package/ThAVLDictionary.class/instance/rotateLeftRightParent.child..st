rotations
rotateLeftRightParent: parent child: child

	| top left right first second third fourth |
	top := child right.
	left := child.
	right := parent.
	
	first := child left.
	second := child right left.
	third := child right right.
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