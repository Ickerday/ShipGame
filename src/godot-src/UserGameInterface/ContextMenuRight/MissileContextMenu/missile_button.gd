extends Control

class_name MissileButton

var item: InventoryItem
@onready var sprite := $HBoxContainer/TextureRect
@onready var button := $HBoxContainer/Button

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	item.item_deleted.connect(_on_item_deleted)
	sprite.texture = item.item_data.inventory_sprite
	button.text = item.item_data.name

###############################################################################
# Public functions                                                            #
###############################################################################

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_item_deleted(item: InventoryItem):
	queue_free()

###############################################################################
# Private functions                                                           #
###############################################################################

