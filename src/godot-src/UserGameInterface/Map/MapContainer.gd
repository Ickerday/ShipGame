extends BoxContainer


@onready var viewport: SubViewport = $Window/SubViewport
@onready var camera: Camera2D = $Window/SubViewport/Camera2D

var requested_camera_zoom = 1.0
@export var max_zoom := 2.5
@export var min_zoom := 0.1
@export var camera_zoom_speed = 1.0
@export var camera_zoom_increment := 0.05
@export var default_zoom_speed := 1.0
var requested_camera_movement = Vector2.ZERO
@export var camera_speed: float = 0.50
@export var max_camera_change: float = 250.0

var player_ref: WeakRef
var track_player_mode: bool = false

###############################################################################
# Builtin functions                                                           #
###############################################################################


func _ready():
	await get_tree().process_frame
	viewport.world_2d = InputMediator.world2D
	player_ref = weakref(InputMediator.player)


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_space"):
		track_player_mode = not track_player_mode
	if track_player_mode:
		var player: CharacterBody2D = player_ref.get_ref()
		if player:
			camera.position = player.global_position


func _process(delta):
	if requested_camera_movement.length() >= max_camera_change:
		requested_camera_movement = requested_camera_movement.normalized() * max_camera_change
	var pos_change = lerp(requested_camera_movement, Vector2.ZERO, camera_speed * delta)
	requested_camera_movement -= pos_change
	camera.position += pos_change
	camera.zoom = lerp(camera.zoom, Vector2(requested_camera_zoom, requested_camera_zoom), min(camera_zoom_speed * delta, 1.0))


func _input(event):
	if event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
		requested_camera_movement += event.relative * (max_zoom - requested_camera_zoom + default_zoom_speed)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			requested_camera_zoom = max(requested_camera_zoom - camera_zoom_increment, min_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			requested_camera_zoom = min(requested_camera_zoom + camera_zoom_increment, max_zoom)


###############################################################################
# Public functions                                                            #
###############################################################################


func resize_window():
	pass


###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################
