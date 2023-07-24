extends Node2D

class_name MapRuler

var point_scene := preload("res://src/godot-src/GameWorld/MapEntities/Ruler/ruler_point.tscn")


@onready var first_point := $ruler_point

var is_first_point_settled = false
var second_point: Node2D

signal ruler_placed

###############################################################################
# Builtin functions                                                           #
###############################################################################


func _draw():
	if second_point:
		draw_dashed_line(Vector2.ZERO, to_local(second_point.global_position), Color.WHITE, 4.0, true)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if !second_point:
			global_position = get_global_mouse_position()
		else:
			second_point.global_position = get_global_mouse_position()
			queue_redraw()
	if event is InputEventMouseButton and event.button_mask == MOUSE_BUTTON_LEFT:
		if !second_point:
			create_second_point()
		else:
			set_process_unhandled_input(false)
			ruler_placed.emit()


###############################################################################
# Public functions                                                            #
###############################################################################

func create_second_point():
	is_first_point_settled = true
	second_point = point_scene.instantiate()
	add_child(second_point)

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################
