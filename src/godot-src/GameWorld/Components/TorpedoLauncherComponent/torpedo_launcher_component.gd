extends Node2D

var torpedo_ref: WeakRef

###############################################################################
# Builtin functions                                                           #
###############################################################################

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


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_mask == MOUSE_BUTTON_LEFT:
		if torpedo_ref.get_ref():
			torpedo_ref.get_ref().delete()
		torpedo_ref = null
		queue_redraw()

###############################################################################
# Public functions                                                            #
###############################################################################

func load_torpedo(torpedo: InventoryItem):
	torpedo_ref = weakref(torpedo)


func unload_torpedo():
	torpedo_ref = null


###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################
