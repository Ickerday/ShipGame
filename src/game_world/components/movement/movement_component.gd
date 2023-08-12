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
@export var acceleration: float = 25

@export var max_rotation: float = 90
@export var rotation_speed: int = 1


###############################################################################
# Class-related variables                                                     #
###############################################################################

var current_velocity: Vector2 = Vector2.ZERO
var current_speed: float = 0.0

var target_speed: float = 0:
	set = set_target_speed
var target_rotation: float = 0:
	set = set_target_rotation
var target_destination: Vector2 = Vector2.ZERO:
	set = set_target_destination

signal body_moved(velocity: Vector2)
signal target_speed_changed(new_speed: float)
signal target_rotation_changed(new_rotation: float)
signal target_destination_changed(new_location: Vector2)

###############################################################################
# Setters                                                                     #
###############################################################################


func set_target_speed(new_speed: float):
	target_speed = max(min(new_speed, max_speed), -max_speed)
	target_speed_changed.emit(target_speed)


func set_target_rotation(new_rotation: float):
	target_rotation = max(min(new_rotation, max_rotation), -max_rotation)
	target_rotation_changed.emit(target_rotation)


func set_target_destination(new_location: Vector2):
	target_destination = new_location
	target_destination_changed.emit(target_destination)


###############################################################################
# Built-in functions                                                          #
###############################################################################


func _ready():
	parent = get_parent()


func _physics_process(delta):
	if not parent:
		return

	if target_destination == Vector2.ZERO:
		parent.set_velocity(_calculate_new_velocity(delta))
		parent.rotation += target_rotation * rotation_speed * delta
		parent.move_and_slide()
		body_moved.emit(parent.velocity)
	else:
		# ! TODO: Move towards target_destination
		pass


###############################################################################
# Connections                                                                 #
###############################################################################


func _on_target_speed_changed(new_speed: float, hard_set: bool = false):
	if hard_set:
		self.target_speed = new_speed
	else:
		self.target_speed += new_speed


func _on_target_rotation_changed(new_rotation: float, hard_set: bool = false):
	if hard_set:
		self.target_rotation = new_rotation
	else:
		self.target_rotation += new_rotation


func _on_target_destination_changed(_new_destination: Vector2) -> void:
	# set_target_rotation(0) # calculate the angle from current X/Y to target X/Y
	var _new_rotation = transform.get_origin()



###############################################################################
# Private functions                                                           #
###############################################################################


func _calculate_new_velocity(_delta: float) -> Vector2:
	current_speed = min(lerp(current_speed, target_speed, acceleration), max_speed)
	var new_velocity = -parent.transform.y * current_speed
	return new_velocity

###############################################################################
# Public functions                                                            #
###############################################################################
