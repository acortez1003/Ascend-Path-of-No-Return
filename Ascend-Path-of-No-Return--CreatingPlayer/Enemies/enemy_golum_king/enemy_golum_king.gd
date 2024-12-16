extends CharacterBody2D

@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D

@export var max_health : int
@export var damage : int

signal death_signal
signal hit
var current_health : int
var player : CharacterBody2D
var knockback : Vector2 = Vector2(-300, -300)
var can_attack : bool
var damage_taken : int

func _ready():
	current_health = max_health
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	can_attack = true
	animated_sprite_2d.flip_h = true

func _physics_process(_delta):
	if current_health <= 0:
			current_health = 0
			death_signal.emit()
			
	if animated_sprite_2d.animation == "death" and animated_sprite_2d.frame == 3:
		queue_free()

func get_damage() -> int:
	player.velocity += knockback
	player.move_and_slide()
	return damage
		
func can_damage() -> bool:
	if animated_sprite_2d.animation == "attack" && animated_sprite_2d.frame == 4:
		return true
	else:
		return false

func register_damage():
	current_health -= damage_taken
		
func take_damage(dmg : int):
	damage_taken = dmg
	hit.emit()
