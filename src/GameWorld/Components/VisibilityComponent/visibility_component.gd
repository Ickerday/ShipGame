extends Node

class_name VisibilityComponent

var is_spotted := false
var should_be_displayed := true

###############################################################################
# Builtin functions                                                           #
###############################################################################


func _ready():
	if not is_spotted:
		get_parent().hide()


###############################################################################
# Public functions                                                            #
###############################################################################

func get_body_data():
	return


func spot() -> void:
	get_parent().show()


func hide() -> void:
	get_parent().hide()


###############################################################################
# Connections                                                                 #
###############################################################################

func _on_damage_component_entity_killed():
	should_be_displayed = false

###############################################################################
# Private functions                                                           #
###############################################################################
