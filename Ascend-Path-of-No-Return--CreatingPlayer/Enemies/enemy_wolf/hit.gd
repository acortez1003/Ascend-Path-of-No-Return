extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

signal damage_dealt

func on_physics_process(delta : float):
	animated_sprite_2d.play("hit")
	damage_dealt.emit()
	
func enter():
	pass
	
func exit():
	pass
