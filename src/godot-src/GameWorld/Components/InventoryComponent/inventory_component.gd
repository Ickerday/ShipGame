extends Node

class_name InventoryComponent

@onready var items: Array[InventoryItem] = []


###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	var debug_items = [
		InventoryItem.new(load("res://data/items/missiles/SimpleTorpedo.tres")),
		InventoryItem.new(load("res://data/items/missiles/SimpleTorpedo.tres")),
		InventoryItem.new(load("res://data/items/missiles/SimpleTorpedo.tres")),
		InventoryItem.new(load("res://data/items/missiles/SimpleTorpedo.tres"))]
	for item in debug_items:
		add_item_to_inventory(item)


###############################################################################
# Public functions                                                            #
###############################################################################

func add_item_to_inventory(item: InventoryItem):
	item.item_deleted.connect(_remove_dead_item_from_inventory)
	items.append(item)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _remove_dead_item_from_inventory(item: InventoryItem):
	items.erase(item)
