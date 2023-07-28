extends Node2D

class_name Wreck

@onready var inventory := $InventoryComponent

###############################################################################
# Builtin functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_plunge_area_area_entered(_area):
	InputMediator.pillage_the_inventory.emit(inventory)


func _on_plunge_area_area_exited(_area):
	InputMediator.stop_the_plunge.emit()


func _on_time_to_plunge_timeout():
	queue_free()


###############################################################################
# Private functions                                                           #
###############################################################################
