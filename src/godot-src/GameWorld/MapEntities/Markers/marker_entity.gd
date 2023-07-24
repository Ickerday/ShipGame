extends Node2D

class_name MarkerEntity

# an entity that this marker points to
var entity_id: int
var perishable := false
var marker_type: MarkerType
var seen: float = 0.0

enum MarkerType {
	Visual,
	Sound
}

@onready var marker_name_label := $VBoxContainer/Name
@onready var marker_seen_label := $VBoxContainer/Seen
@onready var marker_extra_info_label := $VBoxContainer/ExtraInfo

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _process(delta):
	seen += delta
	marker_seen_label.text = "seen " + str(round(seen)) + " seconds ago"


###############################################################################
# Public functions                                                            #
###############################################################################

func set_up(marker_name: String, marker_extra_info: String):
	# todo – display some actually useful information (like ship speed, it's direction and whatnot)
	if not marker_name:
		marker_name_label.queue_free()
	else: 
		marker_name_label.text = marker_name
	if not marker_extra_info:
		marker_extra_info_label.queue_free()
	else:
		marker_extra_info_label.text = marker_extra_info
	

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################
