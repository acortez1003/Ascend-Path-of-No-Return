extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	animated_sprite_2d.play("idle")
	
func enter():
	pass
	
func exit():
	pass
