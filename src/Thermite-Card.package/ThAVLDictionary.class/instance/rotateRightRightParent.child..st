rotations
rotateRightRightParent: parent child: child

	| top left right first second third fourth |
	top := child.
	left := parent.
	right := child right.
	
	first := parent left.
	second := child left.
	third := child right left.
	fourth := child right right.
	
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