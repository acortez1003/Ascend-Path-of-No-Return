extends NodeState

var portal = preload("res://FX/golum_king_attack/golum_king_attack.tscn")

@onready var timer : Timer = $"../../RangeAttackTimer"

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

var player : CharacterBody2D

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	var player_pos = player.global_position
	var offset : Vector2 = Vector2(0, -70)
	var portal_pos = player_pos + offset
	
	if character_body_2d.global_position.x > player_pos.x:
		animated_sprite_2d.flip_h = true
	if character_body_2d.global_position.x < player_pos.x:
		animated_sprite_2d.flip_h = false
		
	if timer.is_stopped():
		var portal_instance = portal.instantiate() as Node2D
		portal_instance.global_position = portal_pos
		get_parent().add_child(portal_instance)
		timer.start()
		
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	
func exit():
	pass


func _on_range_attack_timer_timeout():
	timer.stop()
