structure diff
addFiles: files to: root
	files do: [ :file | self addFile: file to: root ]