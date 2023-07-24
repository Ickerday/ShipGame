extends Node2D

class_name PlayerTorpedoLauncher

var torpedo_ref: WeakRef

###############################################################################
# Builtin functions                                                           #
###############################################################################


func _ready():
	InputMediator.interface_state_changed.connect(unload_torpedo)


func _process(delta):
	if !torpedo_ref:
		return
	var torpedo = torpedo_ref.get_ref()
	if torpedo_ref.get_ref():
		queue_redraw()


func _draw():
	if !torpedo_ref:
		return
	var torpedo: InventoryItem = torpedo_ref.get_ref()
	if !torpedo:
		return
	draw_arc(Vector2.ZERO, torpedo.item_data.range, 0, TAU, 64, Color.RED, 5.0, true)
	var mouse_position = get_local_mouse_position()
	if mouse_position.length() <= torpedo.item_data.range:
		draw_line(Vector2.ZERO, mouse_position, Color.WHITE, 4.0, true)


func _input(event):
	if event is InputEventMouseButton and event.button_mask == MOUSE_BUTTON_LEFT:
		if !torpedo_ref:
			return
		# launch missile
		if torpedo_ref.get_ref():
			torpedo_ref.get_ref().delete()
		torpedo_ref = null
		queue_redraw()


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
