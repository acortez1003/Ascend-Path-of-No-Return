extends NodeState

@onready var muzzle = $"../../Muzzle"

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

var muzzle_pos

func _ready():
	muzzle_pos = muzzle.position

func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	animated_sprite_2d.play("idle")
	
func enter():
	animated_sprite_2d.flip_h = true
	muzzle.position.x = -muzzle_pos.x
	
	
func exit():
	pass
