extends Control

class_name UserInterfaceController

var desired_speed: float
var desired_rotation: float

@onready var labels := {
	"velocity": $HBoxContainer/VBoxContainer/MarginContainer/HBoxContainer/PlayerData/Velocity,
	"rotation": $HBoxContainer/VBoxContainer/MarginContainer/HBoxContainer/PlayerData/Rotation,
	"desired_rotation": $HBoxContainer/VBoxContainer/MarginContainer/HBoxContainer/PlayerData/DesiredRotationChange,
	"desired_speed": $HBoxContainer/VBoxContainer/MarginContainer/HBoxContainer/PlayerData/Speed,
}

signal desired_speed_changed(new_speed: float)
signal desired_rotation_changed(new_rotation: float)

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	InputMediator.connect_interface_to_player_ship(self)


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		desired_speed += 0.5
		desired_speed_changed.emit(desired_speed)
		update_label(desired_speed, "desired_speed")
	elif Input.is_action_just_pressed("ui_down"):
		desired_speed -= 0.5
		desired_speed_changed.emit(desired_speed)
		update_label(desired_speed, "desired_speed")
	elif Input.is_action_just_pressed("ui_left"):
		desired_rotation += 0.05
		desired_rotation_changed.emit(desired_rotation)
		update_label(desired_rotation, "desired_rotation")
	elif Input.is_action_just_pressed("ui_right"):
		desired_rotation -= 0.05
		desired_rotation_changed.emit(desired_rotation)
		update_label(desired_rotation, "desired_rotation")


###############################################################################
# Public functions                                                            #
###############################################################################

func increment_speed(increment: float) -> void:
	desired_speed += increment
	desired_speed_changed.emit(desired_speed)
	update_label(desired_speed, "desired_speed")


func increment_rotation(increment: float) -> void:
	desired_rotation += increment
	desired_rotation_changed.emit(desired_rotation)
	update_label(desired_rotation, "desired_rotation")


func set_desired_speed(value: float) -> void:
	desired_speed = value
	desired_speed_changed.emit(desired_speed)
	update_label(desired_speed, "desired_speed")


func set_desired_rotation(value: float) -> void:
	desired_rotation = value
	desired_rotation_changed.emit(desired_rotation)
	update_label(desired_rotation, "desired_rotation")


func update_label(new_value, label_type: String):
	labels.get(label_type).text = str(new_value)


###############################################################################
# Connections                                                                 #
###############################################################################


###############################################################################
# Private functions                                                           #
###############################################################################
