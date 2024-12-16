extends NodeState

var wave = preload("res://FX/golem_attack/golem_attack.tscn")

@onready var muzzle : Marker2D = $"../../Muzzle"
@onready var timer : Timer = $"../../FX_Timer"

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

var player : CharacterBody2D
var times_played : int = 0
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
	
	if times_played == 0:
		animated_sprite_2d.play("walk")
		times_played += 1
	
	if timer.is_stopped():
		var wave_instance = wave.instantiate() as Node2D
		wave_instance.global_position = muzzle.global_position
		get_parent().add_child(wave_instance)
		timer.start()
		animated_sprite_2d.play("attack")
		
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	
func exit():
	pass

func _on_fx_timer_timeout():
	timer.stop()
	times_played = 0
