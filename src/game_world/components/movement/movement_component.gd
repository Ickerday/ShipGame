extends Node2D
class_name MovementComponent

###############################################################################
# EDITOR                                                                      #
###############################################################################
# for drawing lines, displaying extra data and whatnot
@export var debug := false

###############################################################################
# references                                                                  #
###############################################################################

var parent: CharacterBody2D

###############################################################################
# exports                                                                     #
###############################################################################

@export var max_speed: float = 150.0
@export var max_rotation: float = 2.5
@export var acceleration: float = 25.0
@export var rotation_speed: float = 0.5

###############################################################################
# class-related variables                                                     #
###############################################################################

var desired_speed: float = 0 : set = set_desired_speed
var desired_rotation: float = 0 : set = set_desired_rotation
var velocity: Vector2 = Vector2.ZERO
var current_speed: float = 0.0

signal body_moved(velocity: Vector2)
signal desired_speed_changed(new_speed: Vector2)
signal desired_rotation_changed(new_rotation: Vector2)

###############################################################################
# Setters                                                                     #
###############################################################################


func set_desired_speed(new_speed: float):
	desired_speed = max(min(new_speed, max_speed), -max_speed)
	desired_speed_changed.emit(desired_speed)


func set_desired_rotation(new_rotation):
	desired_rotation = max(min(new_rotation, max_rotation), -max_rotation)
	desired_rotation_changed.emit(desired_rotation)


###############################################################################
# Builtin functions                                                           #
###############################################################################


func _ready():
	parent = get_parent()


func _physics_process(delta):
	if parent:
		parent.set_velocity(_calculate_new_velocity(delta))
		parent.rotation += desired_rotation * rotation_speed * delta
		parent.move_and_slide()
		body_moved.emit(parent.velocity)


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
