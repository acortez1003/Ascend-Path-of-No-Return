extends CharacterBody2D

@export var animated_sprite_2d : AnimatedSprite2D
@export var damage : int
	
var player : CharacterBody2D
var player_moved : bool = false

func _on_remove_timer_timeout():
	queue_free()
	player_moved = false

func _ready():
		player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D

func get_damage() -> int:
	if can_damage:
		damage = 5
	else:
		damage = 0
	return damage
	
func can_damage() -> bool:
	if animated_sprite_2d.frame == 3 || animated_sprite_2d.frame == 4:
		return true
	else:
		return false


func _on_hitbox_body_entered(body):
	if !player_moved:
		player.velocity.y -= 450
		player_moved = true
