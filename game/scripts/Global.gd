extends Node

var unit_deck = []

func _ready():
	var new_card = CardController.new()
	new_card.init(
		'Call of Ground Water',
		'Floods.',
		0,
		10
	)
	
	unit_deck.append(new_card)
