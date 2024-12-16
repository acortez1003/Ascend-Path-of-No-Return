extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$coin_number.text = var_to_str(player_coin_data.coin)


func _on_pause_texture_button_pressed() -> void:
	GameManager.pause_game()
