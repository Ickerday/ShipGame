extends BaseItemResource

class_name MissileResource

@export_group("Missile Data")
@export var max_speed := 160.0
@export var min_speed := 140.0
@export var acceleration := 5.0
@export var missile_range := 250.0
@export var damage := 50.0
@export var map_sprite: Texture
@export var inventory_sprite: Texture
@export var tracking_area: Shape2D
@export var collision_shape: Shape2D
