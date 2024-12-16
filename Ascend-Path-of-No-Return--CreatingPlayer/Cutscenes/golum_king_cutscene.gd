extends Node2D

@onready var canvas : CanvasLayer = $CanvasLayer
@onready var dialogue_box : Panel = $CanvasLayer/DialogueBox
@onready var boss_hp_bar : ProgressBar = $CanvasLayer/BossHealthBar

var player : CharacterBody2D
var camera : Camera2D
var golum_king : CharacterBody2D
var ticks : int = 0
var cutscene_can_start : bool = false

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	camera = get_tree().get_nodes_in_group("Player")[4] as Camera2D
	golum_king = get_tree().get_nodes_in_group("Enemy")[0] as CharacterBody2D
	boss_hp_bar.max_value = golum_king.max_health

func _physics_process(_delta):
	if golum_king != null:
		boss_hp_bar.value = golum_king.current_health
		
		if cutscene_can_start:
			if !player.can_move and ticks < 100:
				camera.cutscene = true
				camera.move_local_x(1)
				ticks += 1
			
			if ticks >= 100 and ticks < 250:
				canvas.visible = true
				dialogue_box.get_child(0).visible = true
				ticks += 1
			
			if ticks >= 250 and ticks < 500:
				dialogue_box.get_child(0).visible = false
				dialogue_box.get_child(1).visible = true
				ticks += 1
			
			if ticks == 500:
				dialogue_box.get_child(1).visible = false
				dialogue_box.visible = false
				player.can_move = true
				golum_king.can_attack = true
				camera.cutscene = false
				boss_hp_bar.visible = true
	else:
		queue_free()

func _on_trigger_area_body_entered(body):
	if body.is_in_group("Player"):
		cutscene_can_start = true
		golum_king.can_attack = false
		player.can_move = false
		player.velocity = Vector2.ZERO
