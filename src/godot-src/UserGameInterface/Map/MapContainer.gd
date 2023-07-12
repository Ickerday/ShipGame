extends BoxContainer


@onready var viewport: SubViewport = $Window/SubViewport

func _ready():
	await get_tree().process_frame
	$Window/SubViewport.world_2d = InputMediator.world2D
