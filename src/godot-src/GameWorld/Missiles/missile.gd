extends CharacterBody2D

class_name Missile

@onready var movement_component := $MovementComponent
@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D
var range: float = 0.0
var range_so_far: float = 0.0
var starting_position: Vector2

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	top_level = true
	starting_position = global_position

func _physics_process(delta):
	await movement_component.body_moved
	var distance_so_far = starting_position.distance_to(global_position)
	if distance_so_far > range:
		queue_free()
	var col = get_last_slide_collision()
	if col:
		var col_obj = col.get_collider()
		if col_obj:
			print("boom!11")
			queue_free()
	
###############################################################################
# Public functions                                                            #
###############################################################################

func from_item(item: InventoryItem):
	assert(item.item_data is MissileResource)
	var item_data: MissileResource = item.item_data
	range = item_data.range
	sprite.texture = item_data.map_sprite
	collision_shape.shape = item_data.collision_shape
	movement_component.max_speed = item_data.max_speed
	movement_component.desired_speed = item_data.max_speed
	movement_component.acceleration = item_data.acceleration
	
###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################
