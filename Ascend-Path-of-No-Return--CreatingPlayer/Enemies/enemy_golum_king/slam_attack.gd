extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int

var player : CharacterBody2D
var times_played : int = 0
var max_speed : int
var x_distance : float
var y_distance: float

func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	var direction : int
	x_distance = player.global_position.x - character_body_2d.global_position.x
	y_distance = player.global_position.y - character_body_2d.global_position.y
	
	if character_body_2d.global_position > player.global_position:
		direction = -1
		animated_sprite_2d.flip_h = true
	if character_body_2d.global_position < player.global_position:
		direction = 1
		animated_sprite_2d.flip_h = false
	
	if x_distance <= 40 && x_distance >= -40 && y_distance <= 70 && y_distance >= -70:
		animated_sprite_2d.play("attack")
	elif times_played == 0:
		animated_sprite_2d.play("walk")
		times_played += 1
	else:
		times_played = 0
		
	character_body_2d.velocity.x += direction * speed * delta
	character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_speed, max_speed)
	character_body_2d.move_and_slide()
	
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	max_speed = speed + 5
	
func exit():
	pass
