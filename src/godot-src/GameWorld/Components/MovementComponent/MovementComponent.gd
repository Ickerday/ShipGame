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

@export var max_speed: float
@export var acceleration: float
@export var rotation_speed: float

###############################################################################
# class-related variables                                                     #
###############################################################################

var desired_speed: float = 0 : set = set_desired_speed
var desired_rotation: float = 0 : set = set_desired_rotation
var velocity: Vector2 = Vector2.ZERO
var current_speed: float = 0.0

signal body_moved(velocity: Vector2)

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

func set_desired_speed(new_speed):
	desired_speed = min(new_speed, max_speed)


func set_desired_rotation(new_rotation):
	desired_rotation = new_rotation
