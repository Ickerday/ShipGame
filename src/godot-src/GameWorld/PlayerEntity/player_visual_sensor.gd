# a node responsible for updating Markers on player map

extends Node2D

class_name VisionComponent

@onready var sensor: Area2D = $Area2D
@export var sensor_range: float = 120.0
var bodies_in_range: Array = []

signal body_spotted(visibility_component: VisibilityComponent)
signal body_left_sight(visibility_component: VisibilityComponent)

###############################################################################
# Builtin functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func spot_the_body(body: Node) -> void:
	# emitted when the new body is in sight – usually tells the body to uncover itself.
	if body.has_node("VisibilityComponent"):
		var body_id = body.get_parent().get_instance_id()
		var visibility_component: VisibilityComponent = body.get_node("VisibilityComponent")
		visibility_component.spot()
		# IR signature detected
		body_spotted.emit(visibility_component)


func forget_the_body(body: Node) -> void:
	# emitted when the new body leaves the sight – usually tells the body to cover itself.
	if body.has_node("VisibilityComponent"):
		var body_id = body.get_parent().get_instance_id()
		var visibility_component: VisibilityComponent = body.get_node("VisibilityComponent")
		visibility_component.hide()
		body_left_sight.emit(visibility_component)

###############################################################################
# Connections                                                                 #
###############################################################################


###############################################################################
# Private functions                                                           #
###############################################################################
