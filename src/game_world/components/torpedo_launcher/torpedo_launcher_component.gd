extends Node2D

class_name PlayerTorpedoLauncher

var torpedo_ref: WeakRef
var torpedo_scene := preload("res://src/game_world/map_entities/missile/missile_entity.tscn")

###############################################################################
# Builtin functions                                                           #
###############################################################################


func _ready():
	InputMediator.interface_state_change_requested.connect(unload_torpedo)


func _process(_delta):
	if !torpedo_ref:
		return

	queue_redraw()


func _draw():
	if !torpedo_ref:
		return

	var torpedo: InventoryItem = torpedo_ref.get_ref()
	if !torpedo:
		return

	draw_arc(Vector2.ZERO, torpedo.item_data.missile_range, 0, TAU, 64, Color.RED, 5.0, true)
	var mouse_position = get_local_mouse_position()
	if mouse_position.length() <= torpedo.item_data.missile_range:
		draw_line(Vector2.ZERO, mouse_position, Color.WHITE, 4.0, true)


func _input(event):
	if event is InputEventMouseButton and event.button_mask == MOUSE_BUTTON_LEFT:
		_fire_torpedo()


###############################################################################
# Public functions                                                            #
###############################################################################


func load_torpedo(torpedo: InventoryItem):
	torpedo_ref = weakref(torpedo)


func unload_torpedo(op_args: Variant = null):
	if op_args == GameInputMediator.InterfaceState.MissileLaunch:
		return

	torpedo_ref = null
	queue_redraw()


###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################


func _create_and_fire_new_missile(missile: InventoryItem):
	# TODO – Maybe use InputMediator to manage this relationship
	var game_world = get_tree().get_nodes_in_group("GameWorld")
	if !game_world:
		return

	game_world[0].create_new_missile(missile, get_parent(), get_global_mouse_position())
	missile.delete()


func _fire_torpedo():
	if !torpedo_ref:
		return

	var torpedo = torpedo_ref.get_ref()
	if !torpedo:
		unload_torpedo()
		return

	_create_and_fire_new_missile(torpedo)
	unload_torpedo()
