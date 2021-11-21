extends Node

class_name GenericHelper

static func create_map(w, h):
	var map = []
	for x in range(w):
		var col = []
		col.resize(h)
		map.append(col)
		
	return map
