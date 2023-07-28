extends Node

# todo – maybe it would be better to use object/refcounted instead?

class_name InventoryComponent

@onready var items: Array[InventoryItem] = []


###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	tree_exiting.connect(clear)

###############################################################################
# Public functions                                                            #
###############################################################################

func add_item_to_inventory(item: InventoryItem):
	item.item_deleted.connect(_remove_dead_item_from_inventory)
	items.append(item)


func transfer_to_other_inventory(other: InventoryComponent):
	for _i in items.size():
		var item = items.pop_back()
		other.add_item_to_inventory(item)


func clear():
	for _i in items.size():
		var item: InventoryItem = items.pop_back()
		item.delete()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _remove_dead_item_from_inventory(item: InventoryItem):
	items.erase(item)
