extends CanvasLayer

var settings_menu_screen = preload("res://Scenes/UI/settings_menu_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	GameManager.start_game()
	queue_free()


func _on_exit_button_pressed() -> void:
	GameManager.exit_game()


func _on_settings_button_pressed() -> void:
	var settings_menu_screen_instance = settings_menu_screen.instantiate()
	get_tree().get_root().add_child(settings_menu_screen_instance)
