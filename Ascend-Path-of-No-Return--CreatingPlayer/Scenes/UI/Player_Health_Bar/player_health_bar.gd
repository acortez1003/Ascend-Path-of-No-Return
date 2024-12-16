extends Node2D

@onready var health_bar : TextureProgressBar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	HealthManager.player_health_changed.connect(on_player_health_changed)


func on_player_health_changed(hp : int):
	var health : float = (hp as float/ HealthManager.max_health as float) * 100
	print(health)
	health_bar.value = health
