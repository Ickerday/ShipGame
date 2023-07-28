extends Node

# todo – it might be worth to pack all the stats into resource
@export var base_hp: float = 50.0
var current_hp: float

signal entity_damaged
signal entity_killed()

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	current_hp = base_hp


###############################################################################
# Public functions                                                            #
###############################################################################

func impact(damage: float):
	current_hp -= damage
	entity_damaged.emit()
	
	if current_hp <= 0:
		entity_killed.emit()



###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################
