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


func _on_pillage_area_area_entered(_area):
	InputMediator.pillage_inventory_started.emit(inventory)


func _on_pillage_area_area_exited(_area):
	InputMediator.stop_pillage.emit()


func _on_time_to_pillage_timeout():
	queue_free()

###############################################################################
# Private functions                                                           #
###############################################################################
