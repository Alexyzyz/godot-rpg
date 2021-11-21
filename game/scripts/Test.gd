extends Control

class_name Test

var title: String
var desc: String

var ap_cost: int
var mp_cost: int

var i = 0
	
func _gui_input(event):
	print(i)
	i += 1
