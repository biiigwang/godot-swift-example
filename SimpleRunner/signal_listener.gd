extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_level_player_entry_teleport(new_player_positon):
	print("Player entry teleport, new positon is {%s}" % new_player_positon)
