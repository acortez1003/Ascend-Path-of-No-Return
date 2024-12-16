extends CanvasLayer

func _ready():
	self.hide()

func game_over():
	print("Game Over screen displayed")
	self.show()
	get_tree().paused = true

func _on_retry_button_pressed():
	print("Retry button pressed")
	self.hide()
	GameManager.restart_game()
