extends Node2D

var marker_scene := preload("res://src/godot-src/GameWorld/MapEntities/Markers/MarkerEntity.tscn")
var ruler_scene := preload("res://src/godot-src/GameWorld/MapEntities/Ruler/Ruler.tscn")
#var pen_scene := preload()
@onready var markers_on_map: Dictionary = {}

var label_to_add: Node2D

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	await get_tree().process_frame
	connect_player_vision_and_hearing()
	connect_to_user_interface()


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
		if label_to_add:
			label_to_add.queue_free()
			label_to_add = null
			InputMediator.request_interface_state_change(GameInputMediator.InterfaceState.FreeLook)

###############################################################################
# Public functions                                                            #
###############################################################################

func add_new_label():
	pass


func add_new_ruler():
	var new_ruler = ruler_scene.instantiate()
	add_child(new_ruler)
	new_ruler.ruler_placed.connect(remove_label_to_add)
	label_to_add = new_ruler


func add_new_visual_marker(visibility_component: VisibilityComponent):
	if !visibility_component.should_be_displayed:
		return
	var entity_id = visibility_component.get_parent().get_instance_id()
	if markers_on_map.get(entity_id):
		return
	var new_marker = marker_scene.instantiate()
	new_marker.global_position = visibility_component.get_parent().global_position
	add_child(new_marker)
	new_marker.set_up("Some Ship Name", "Cruiser")
	markers_on_map[entity_id] = new_marker


func remove_visual_marker(visibility_component: VisibilityComponent):
	var entity_id = visibility_component.get_parent().get_instance_id()
	var marker = markers_on_map.get(entity_id)
	if !marker:
		return
	marker.queue_free()
	markers_on_map.erase(entity_id)


func remove_label_to_add():
	label_to_add = null

func queue_label_to_add():
	if !label_to_add:
		return
	label_to_add.queue_free()
	label_to_add = null

###############################################################################
# Connections                                                                 #
###############################################################################


func _on_user_interface_changed(new_interface_state: GameInputMediator.InterfaceState):
	queue_label_to_add()
	match new_interface_state:
		GameInputMediator.InterfaceState.UseRuler:
			add_new_ruler()
		GameInputMediator.InterfaceState.UsePen:
			add_new_label()
		_:
			pass


func connect_player_vision_and_hearing():
	var player_ref = InputMediator.player
	if !player_ref:
		return
	var player: CharacterBody2D = player_ref.get_ref()
	if !player:
		return
	var vision_component: VisionComponent = player.get_node("VisionComponent")
	vision_component.body_spotted.connect(remove_visual_marker)
	vision_component.body_left_sight.connect(add_new_visual_marker)


func connect_to_user_interface():
	InputMediator.interface_state_changed.connect(_on_user_interface_changed)

###############################################################################
# Private functions                                                           #
###############################################################################
