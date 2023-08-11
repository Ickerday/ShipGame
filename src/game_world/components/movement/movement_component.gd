extends Node2D
class_name MovementComponent

###############################################################################
# EDITOR                                                                      #
###############################################################################
# For drawing lines, displaying extra data and whatnot
@export var debug := false

###############################################################################
# References                                                                  #
###############################################################################

var parent: CharacterBody2D

###############################################################################
# Exports                                                                     #
###############################################################################

@export var max_speed: float = 150.0
@export var max_rotation: float = 2.5
@export var acceleration: float = 25.0
@export var rotation_speed: float = 0.5

###############################################################################
# Class-related variables                                                     #
###############################################################################

var desired_speed: float = 0:
	set = set_desired_speed
var desired_rotation: float = 0:
	set = set_desired_rotation

enum MovementMode { MANUAL = 0, AUTO = 1 }
var movement_mode: MovementMode = MovementMode.MANUAL

# TODO: "destination"?
var desired_position: Vector2 = Vector2.ZERO:
	set = set_desired_position

var velocity: Vector2 = Vector2.ZERO
var current_speed: float = 0.0

signal body_moved(velocity: Vector2)
signal desired_speed_changed(new_speed: Vector2)
signal desired_rotation_changed(new_rotation: Vector2)
signal desired_position_changed(new_location: Vector2)

###############################################################################
# Setters                                                                     #
###############################################################################


func set_desired_speed(new_speed: float):
	desired_speed = max(min(new_speed, max_speed), -max_speed)
	desired_speed_changed.emit(desired_speed)


func set_desired_rotation(new_rotation: float):
	desired_rotation = max(min(new_rotation, max_rotation), -max_rotation)
	desired_rotation_changed.emit(desired_rotation)


func set_desired_position(new_location: Vector2):
	movement_mode = MovementMode.AUTO
	desired_position = new_location
	desired_position_changed.emit(desired_position)


###############################################################################
# Builtin functions                                                           #
###############################################################################


func _ready():
	parent = get_parent()


func _physics_process(delta):
	if not parent:
		return

	if movement_mode == MovementMode.MANUAL:
		parent.set_velocity(_calculate_new_velocity(delta))
		parent.rotation += desired_rotation * rotation_speed * delta
		parent.move_and_slide()
		body_moved.emit(parent.velocity)

	if movement_mode == MovementMode.AUTO:
		# ! TODO
		pass


###############################################################################
# Connections                                                                 #
###############################################################################


func at_new_desired_speed(new_speed: float, hard_set: bool = false):
	if hard_set:
		self.desired_speed = new_speed
	else:
		self.desired_speed += new_speed


func at_new_desired_rotation(new_rotation: float, hard_set: bool = false):
	if hard_set:
		self.desired_rotation = new_rotation
	else:
		self.desired_rotation += new_rotation


###############################################################################
# Private functions                                                           #
###############################################################################


func _calculate_new_velocity(_delta: float) -> Vector2:
	current_speed = min(lerp(current_speed, desired_speed, acceleration), max_speed)
	var new_velocity = -parent.transform.y * current_speed
	return new_velocity

###############################################################################
# Public functions                                                            #
###############################################################################
