extends Node

signal camera_tracks_player_changed(new_camera_tracks_player: bool)

signal target_speed_changed(new_speed: Vector2, hard_set: bool)
signal target_rotation_changed(new_rotation: Vector2, hard_set: bool)
signal target_destination_changed(new_destination: Vector2)
