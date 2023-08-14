extends CharacterBody2D

class_name PlayerEntity

@onready var movement_component := $MovementComponent

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	InputMediator.register_player(self)
	connect_player_ship_to_event_bus()

###############################################################################
# Public functions                                                            #
###############################################################################

###############################################################################
# Connections                                                                 #
###############################################################################

func connect_player_ship_to_event_bus():
	PlayerEventBus.target_destination_changed.connect(movement_component._on_target_speed_changed)
	PlayerEventBus.target_rotation_changed.connect(movement_component._on_target_rotation_changed)
	PlayerEventBus.target_speed_changed.connect(movement_component._on_target_speed_changed)


###############################################################################
# Private functions                                                           #
###############################################################################
