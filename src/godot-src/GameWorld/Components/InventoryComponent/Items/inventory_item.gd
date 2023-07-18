extends Object

class_name InventoryItem

# todo: fix naive/blanket implementation
var item_id: int
var item_type: ItemType
var item_data: BaseItemResource

enum ItemType {
	Loot,
	Missile
}

signal item_deleted(item: InventoryItem)

###############################################################################
# Builtin functions                                                           #
###############################################################################


func _init(new_item_data):
	item_data = new_item_data
	if item_data is MissileResource:
		item_type = ItemType.Missile
	else:
		item_type = ItemType.Loot


###############################################################################
# Public functions                                                            #
###############################################################################

func delete():
	item_deleted.emit(self)
	call_deferred("free")

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################
