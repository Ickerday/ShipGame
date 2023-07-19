extends Control

class_name MissileContextMenu

var inventory_ref: WeakRef
var missile_button_scene := preload("res://src/godot-src/UserGameInterface/ContextMenuRight/MissileContextMenu/MissileButton.tscn")
@onready var missile_container := $VBoxContainer

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	await get_tree().process_frame
	var player_ref = InputMediator.player
	assert(player_ref)
	var player: CharacterBody2D = player_ref.get_ref()
	inventory_ref = weakref(player.get_node("InventoryComponent"))

###############################################################################
# Public functions                                                            #
###############################################################################

func activate():
	var inventory: InventoryComponent = inventory_ref.get_ref()
	if not inventory:
		print("couldn't find any inventory to display!")
		return
	_sync_missiles_with_inventory(inventory)
	show()


func deactivate():
	hide()


###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################


func _is_item_displayed(item: InventoryItem):
	for missile in missile_container.get_children():
		if missile.item == item:
			return true
	return false

func _sync_missiles_with_inventory(inventory: InventoryComponent):
	for i in inventory.items.size():
		var item = inventory.items[i]
		if item.item_type == InventoryItem.ItemType.Missile and !_is_item_displayed(item):
			var new_missile = missile_button_scene.instantiate()
			new_missile.item = item
			missile_container.add_child(new_missile)