# a node responsible for manging all the connections between different nodes
# it's also responsible for managing input/output

extends Node

class_name GameInputMediator

var gameworld: Node2D
var world2D: World2D
var player: WeakRef
var user_interface: WeakRef
var current_interface_state := InterfaceState.FreeLook

signal new_desired_speed(new_speed: Vector2, hard_set: bool)
signal new_desired_rotation(new_rotation: Vector2, hard_set: bool)

signal interface_state_change_requested(new_state: InterfaceState)
signal interface_state_changed(new_state: InterfaceState)

signal entity_destroyed(entity: Variant)

signal pillage_the_inventory(inventory: InventoryComponent)
signal stop_the_plunge

enum InterfaceState {
	FreeLook,
	MissileLaunch,
	UseRuler,
	UsePen
}

###############################################################################
# Builtin functions                                                           #
###############################################################################


func _physics_process(_delta):
	_check_for_actions()


###############################################################################
# Public functions                                                            #
###############################################################################


func request_interface_state_change(new_state: InterfaceState):
	if new_state != current_interface_state:
		# "exit"
		interface_state_change_requested.emit(new_state)
		current_interface_state = new_state
		# "enter"
		interface_state_changed.emit(new_state)


func register_world(world):
	world2D = world


func register_player(new_player: CharacterBody2D):
	player = weakref(new_player)
	var player_movement_component: MovementComponent = new_player.get_node("MovementComponent")
	new_desired_speed.connect(player_movement_component.at_new_desired_speed)
	new_desired_rotation.connect(player_movement_component.at_new_desired_rotation)


###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

func _check_for_actions():
	var desired_speed_change: float = 0.5 * (int(Input.is_action_just_pressed("move_up")) - int(Input.is_action_just_pressed("move_down")))
	if !is_zero_approx(desired_speed_change):
		new_desired_speed.emit(desired_speed_change, false)

	var desired_rotation_change: float = 0.1 * (int(Input.is_action_just_pressed("turn_right")) - int(Input.is_action_just_pressed("turn_left")))
	if !is_zero_approx(desired_rotation_change):
		new_desired_rotation.emit(desired_rotation_change, false)
