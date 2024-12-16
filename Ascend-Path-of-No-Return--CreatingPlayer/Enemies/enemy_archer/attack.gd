extends NodeState

var laser = preload("res://FX/laser/sentinel_laser.tscn")

@onready var muzzle : Marker2D = $"../../Muzzle"
@onready var timer : Timer = $"../../MissileTimer"

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

var player : CharacterBody2D
var muzzle_pos

func _ready():
	muzzle_pos = muzzle.position
	
func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	var direction : int
	
	if character_body_2d.global_position > player.global_position:
		animated_sprite_2d.flip_h = true
		direction = -1
		muzzle.position.x = -muzzle_pos.x
	if character_body_2d.global_position < player.global_position:
		animated_sprite_2d.flip_h = false
		direction = 1
		muzzle.position.x = muzzle_pos.x
	
	if timer.is_stopped():
		var laser_instance = laser.instantiate() as Node2D
		laser_instance.direction = direction
		laser_instance.global_position = muzzle.global_position
		get_parent().add_child(laser_instance)
		timer.start()
		
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	
func exit():
	pass
	
func _on_missile_timer_timeout():
	timer.stop()
