accessing
parentsSha
	^ (json at: 'parents') collect: [:parent | parent at: 'sha' ]