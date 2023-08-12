# A Node responsible for managing all the connections
# between different nodes as well as managing input/output

extends Node

class_name GameInputMediator

###############################################################################
# References                                                                  #
###############################################################################

var game_world: Node2D
var world2D: World2D
var player: WeakRef

var user_interface: WeakRef
var current_interface_state := InterfaceState.FreeLook

###############################################################################
# Signals                                                                     #
###############################################################################

signal interface_state_change_requested(new_state: InterfaceState)
signal interface_state_changed(new_state: InterfaceState)

signal center_camera_changed(new_center_camera: bool)

signal target_speed_changed(new_speed: Vector2, hard_set: bool)
signal target_rotation_changed(new_rotation: Vector2, hard_set: bool)

signal entity_destroyed(entity: Variant)

signal pillage_inventory_started(inventory: InventoryComponent)
signal pillage_inventory_stopped

enum InterfaceState { FreeLook, MissileLaunch, UseRuler, UsePen }

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


func register_world(world: World2D):
	world2D = world


func register_player(new_player: CharacterBody2D):
	player = weakref(new_player)
	var player_movement_component: MovementComponent = new_player.get_node("MovementComponent")
	target_speed_changed.connect(player_movement_component._on_target_speed_changed)
	target_rotation_changed.connect(player_movement_component._on_target_rotation_changed)


###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################


func _check_for_actions():
	var target_speed_change: float = (
		0.5
		* (
			int(Input.is_action_just_pressed("move_up"))
			- int(Input.is_action_just_pressed("move_down"))
		)
	)
	if !is_zero_approx(target_speed_change):
		target_speed_changed.emit(target_speed_change, false)

	var target_rotation_change: float = (
		0.1
		* (
			int(Input.is_action_just_pressed("turn_right"))
			- int(Input.is_action_just_pressed("turn_left"))
		)
	)
	if !is_zero_approx(target_rotation_change):
		target_rotation_changed.emit(target_rotation_change, false)
