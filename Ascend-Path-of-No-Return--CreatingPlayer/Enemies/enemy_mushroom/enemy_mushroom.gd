extends CharacterBody2D

@onready var health_bar : ProgressBar = $HealthBar
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D

@export var damage : int
@export var max_health : int

signal hit
signal death
var current_health : int
var damage_taken : int
	
func _ready():
	current_health = max_health
	health_bar.max_value = max_health 

func _physics_process(delta):
	health_bar.value = current_health
		
	if health_bar.value < health_bar.max_value:
		health_bar.visible = true
	else:
		health_bar.visible = false

	if current_health <= 0:
			current_health = 0
			death.emit()
			
	if animated_sprite_2d.animation == "death" and animated_sprite_2d.frame == 14:
		queue_free()
			
func get_damage() -> int:
	return damage
		
func can_damage() -> bool:
	if animated_sprite_2d.animation == "attack" && animated_sprite_2d.frame == 6:
		return true
	else:
		return false
		
func register_damage():
	current_health -= damage_taken
		
func take_damage(dmg : int):
	damage_taken = dmg
	hit.emit()
