extends Control

class_name MissileContextMenu

var inventory_ref: WeakRef
var torpedo_launcher_ref: WeakRef
var missile_button_scene := preload("res://src/user_interface/context_menu/missile_context_menu/missile_button.tscn")
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
	torpedo_launcher_ref = weakref(player.get_node("TorpedoLauncherComponent"))

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
	# todo – store hashes or ids instead of checking for all the references…
	for missile in missile_container.get_children():
		if missile.item == item:
			return true

	return false

func _sync_missiles_with_inventory(inventory: InventoryComponent):
	var torpedo_launcher = torpedo_launcher_ref.get_ref()

	for i in inventory.items.size():
		var item = inventory.items[i]

		if item.item_type == InventoryItem.ItemType.Missile and !_is_item_displayed(item):
			var new_missile = missile_button_scene.instantiate()
			new_missile.item = item
			missile_container.add_child(new_missile)
			new_missile.button.pressed.connect(torpedo_launcher.load_torpedo.bind(item))
			new_missile.button.pressed.connect(InputMediator.request_interface_state_change.bind(GameInputMediator.InterfaceState.MissileLaunch))
