extends Node2D

@onready var entities := $Entities

var missile_scene := preload("res://src/godot-src/GameWorld/Missiles/Missile.tscn")

###############################################################################
# Builtin functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func create_new_missile(missile_data: InventoryItem, launcher: CharacterBody2D, launch_target: Vector2):
	var new_missile = missile_scene.instantiate()
	new_missile.add_collision_exception_with(launcher)
	new_missile.global_position = launcher.global_position
	new_missile.rotation = Vector2.DOWN.rotated(launcher.global_position.angle_to_point(launch_target)).angle()
	entities.add_child(new_missile)
	new_missile.from_item(missile_data)


###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################
