extends Node2D

@onready var entities := $Entities

var missile_scene := preload("res://src/GameWorld/Missiles/Missile.tscn")

var wreck_scene := preload("res://src/GameWorld/WreckEntity/Wreck.tscn")


###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	InputMediator.entity_destroyed.connect(_on_entity_killed)

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


func create_new_wreck_from_entity(entity: CharacterBody2D):
	var new_wreck: Node2D = wreck_scene.instantiate()
	new_wreck.global_position = entity.get_global_position()
	entities.add_child(new_wreck)
	if entity.has_node("InventoryComponent"):
		var wreck_inventory: InventoryComponent = new_wreck.get_node("InventoryComponent")
		var entity_inventory: InventoryComponent = entity.get_node("InventoryComponent")
		entity_inventory.transfer_to_other_inventory(wreck_inventory)


###############################################################################
# Connections                                                                 #
###############################################################################


func _on_entity_killed(entity: Variant):
	print(entity)
	if entity is Node and (entity as Node).is_in_group("Wreckable"):
		create_new_wreck_from_entity(entity as CharacterBody2D)
		


###############################################################################
# Private functions                                                           #
###############################################################################
