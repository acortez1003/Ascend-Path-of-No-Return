extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int

var player : CharacterBody2D
var times_played : int = 0
var max_speed : int

func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	var direction : int
	
	if character_body_2d.global_position > player.global_position:
		direction = -1
		animated_sprite_2d.flip_h = true
	if character_body_2d.global_position < player.global_position:
		direction = 1
		animated_sprite_2d.flip_h = false
	
	if times_played == 0:
		animated_sprite_2d.play("walk")
		times_played += 1
		
	character_body_2d.velocity.x += direction * speed * delta
	character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_speed, max_speed)
	character_body_2d.move_and_slide()
	
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	max_speed = speed + 5
	
func exit():
	pass

func _on_hitbox_area_entered(area):
	if area.is_in_group("Player"):
		animated_sprite_2d.play("attack")


func _on_hitbox_area_exited(area):
	times_played = 0
