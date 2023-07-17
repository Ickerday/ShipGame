# a node responsible for manging all the connections between different nodes
# it's also responsible for managing input/output

extends Node

var gameworld: Node2D
var world2D: World2D
var player: CharacterBody2D

###############################################################################
# Builtin functions                                                           #
###############################################################################


###############################################################################
# Public functions                                                            #
###############################################################################

func register_world(world):
	world2D = world

func register_player(new_player: CharacterBody2D):
	player = new_player

###############################################################################
# Connections                                                                 #
###############################################################################


func connect_interface_to_player_ship(interface):
	if not player:
		await get_tree().process_frame
		assert(player, "couldn't find player in the current scene!")
	var movement_component: MovementComponent = player.get_node("MovementComponent")
	interface.desired_speed_changed.connect(movement_component.set_desired_speed)
	interface.desired_rotation_changed.connect(movement_component.set_desired_rotation)
	movement_component.body_moved.connect(interface.update_label.bind("velocity"))


###############################################################################
# Private functions                                                           #
###############################################################################
