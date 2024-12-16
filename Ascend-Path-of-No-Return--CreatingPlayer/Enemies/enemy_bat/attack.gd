extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int

var player : CharacterBody2D
var times_played : int = 0

func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	var offset : Vector2
	if character_body_2d.global_position > player.global_position:
		offset = Vector2(10,10)
		animated_sprite_2d.flip_h = false
	if character_body_2d.global_position < player.global_position:
		offset = Vector2(-10,10)
		animated_sprite_2d.flip_h = true
	
	if times_played == 0:
		animated_sprite_2d.play("walk")
		times_played += 1
		
	var player_loc = player.position + offset
	var direction = (player_loc - character_body_2d.position)
	character_body_2d.velocity = direction * speed
	character_body_2d.move_and_slide()
	
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	
func exit():
	pass

func _on_hitbox_area_entered(area):
	if area.is_in_group("Player"):
		animated_sprite_2d.play("attack")


func _on_hitbox_area_exited(area):
	times_played = 0
