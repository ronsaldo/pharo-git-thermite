instance creation
open
	"
	self new open
	"
	| v labels |
	v := RTView new.
	labels := RTGroup new.
	labels
		add:
			(RTLabel
				elementOn: 'Problems and bugs can be reported on:').
				

	labels
		add:
			((RTLabel new color: Color veryVeryDarkGray)
				elementOn: 'https://github.com/ronsaldo/pharo-git-thermite/issues').
				
	v add: labels.
	RTVerticalLineLayout on: labels.


	"Adding animation"
	v openInWindowSized: 600 @ 400 titled: 'GitStats - GitHub Analysis Tool'