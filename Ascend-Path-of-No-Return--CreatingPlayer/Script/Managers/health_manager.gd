extends Node

var max_health : int = 20
var current_health : int
signal player_health_changed

func _ready():
	current_health = max_health


func decrease_health(damage : int):
	current_health -= damage
	
	if current_health < 0:
		current_health = 0
		
	player_health_changed.emit(current_health)
	
func increase_health(heal : int):
	current_health += heal
	
	if current_health > max_health:
		current_health = max_health
