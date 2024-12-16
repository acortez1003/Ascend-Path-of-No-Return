extends CharacterBody2D

@onready var inv_timer : Timer = $Invincible_Timer

@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int 
@export var jump_v : int
@export var jump_h : int
@export var jump_max : int
@export var dash_distance : int
@export var damage_amount : int

const GRAVITY = 1000

enum State { Idle, Run, Jump, Dash, Attack, Dead}

var can_move : bool
var is_in_enemy : bool = false
var invincible : bool = false
var enemy_area : Area2D
var current_state
var jump_count : int = 0
var dashing : bool = false
var attacking : bool = false
var is_in_range : bool = false
var enemy : Area2D
var dying : bool = false

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	can_move = true
	get_tree().paused = false
	SceneManager.on_trigger_player_spawn.connect(_on_spawn)
	current_state = State.Idle

func _on_spawn(pos : Vector2, direction: String):
	can_move = true
	global_position = pos # Move the player to the spawn point
	if direction == "left":
		animated_sprite_2d.flip_h = true  # Face left
		animated_sprite_2d.play("idle")  # Start with the idle animation
	elif direction == "right":
		animated_sprite_2d.flip_h = false  # Face right
		animated_sprite_2d.play("idle")  # Start with the idle animation
	else:
		animated_sprite_2d.play("idle")

		
func _physics_process(delta):
	# Gravity
	player_falling(delta)
	
	#motion
	if can_move and !dashing and !attacking and !dying:
		player_idle(delta)
		player_run(delta)
		player_jump(delta)
		player_dash(delta)
		player_attack(delta)
			
	move_and_slide()
	
	if animated_sprite_2d.animation == "dash" and animated_sprite_2d.frame == 3:
		dashing = false
	if animated_sprite_2d.animation == "attack" and animated_sprite_2d.frame == 1:
		attacking = false
	if animated_sprite_2d.animation == "death" and animated_sprite_2d.frame == 19:
			GameManager.game_over()
	
	player_animation()

	# Enemy interaction
	if is_in_enemy:
		if enemy_area != null:
			var node = enemy_area.get_parent() as Node
				
			#print("Can Damage Value: ", node.can_damage())
			if node.can_damage() and !invincible:
				#hit
				var tween = get_tree().create_tween()
				tween.tween_property(animated_sprite_2d, "material:shader_parameter/enabled", true, 0)
				tween.tween_property(animated_sprite_2d, "material:shader_parameter/enabled", false, 0.2)
				hit.emit()
				
				#knockback
				if animated_sprite_2d.flip_h:
					velocity = Vector2(1000, -300)
				else:
					velocity = Vector2(-1000, -300)
				
				#update health
				HealthManager.decrease_health(node.get_damage())
				
	#Game Over
	if HealthManager.current_health <= 0:
		current_state = State.Dead
		dying = true

func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
func player_idle(delta):
	if is_on_floor():
		current_state = State.Idle
		
func player_run(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 300)
		
	if direction != 0:
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_jump(delta):
	if Input.is_action_just_pressed("jump"):
		if jump_count < jump_max:
			velocity.y = jump_v
			current_state = State.Jump
			jump_count += 1
		
	if !is_on_floor() and current_state == State.Jump:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * jump_h * delta
		
	if is_on_floor() and current_state != State.Jump:
		jump_count = 0

func player_dash(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("dash"):
		velocity.x = direction * dash_distance
		current_state = State.Dash
		dashing = true
		
func player_attack(delta):
	if Input.is_action_just_pressed("attack"):
		current_state = State.Attack
		attacking = true
		if enemy != null and is_in_range:
			var node = enemy.get_parent() as Node
			node.take_damage(damage_amount)
			node.register_damage()

func player_animation():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("walk")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
	elif current_state == State.Dash:
		animated_sprite_2d.play("dash")
	elif current_state == State.Attack:
		animated_sprite_2d.play("attack")
	elif current_state == State.Dead:
		animated_sprite_2d.play("death")

# Handle hitbox interactions
func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		is_in_enemy = true
		enemy_area = area

func _on_hit():
	invincible = true
	if inv_timer.is_stopped():
		inv_timer.start()

func _on_invincible_timer_timeout():
	invincible = false
	inv_timer.stop()


func _on_attack_area_area_entered(area):
	if area.is_in_group("Enemy") and !area.is_in_group("Projectiles"):
		is_in_range = true
		enemy = area
