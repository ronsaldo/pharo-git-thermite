rotations
rotateRightLeftParent: parent child: child

	| top left right first second third fourth |
	top := child left.
	left := parent.
	right := child.
	
	first := parent left.
	second := child left left.
	third := child left right.
	fourth := child right.
	
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