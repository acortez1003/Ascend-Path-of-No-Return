extends Node

var area_1 = preload("res://Levels/prison_level.tscn")
var main_menu_screen = preload("res://Scenes/UI/main_menu_screen.tscn")
var pause_menu_screen = preload("res://Scenes/UI/pause_menu_screen.tscn")
var GameOverScreen = preload("res://Scenes/UI/gameover_screen.tscn")
var game_screen = preload("res://Scenes/UI/game_screen.tscn")
var gameoverscreen_instance: Node = null
var cutscene_1_played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color(Color(0.34, 0.16, 0.63, 1.00))
	
	SettingsManager.load_settings()

func start_game():
	if get_tree().paused:
		continue_game()
		return

	transition_to_scene(area_1.resource_path)
	
	if not get_tree().get_root().has_node("GameScreen"):
		var game_screen_instance = game_screen.instantiate()
		game_screen_instance.name = "GameScreen"  # Give it a unique name
		get_tree().get_root().add_child(game_screen_instance)
		
	if not cutscene_1_played:
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/open_cutscene.dialogue"), "open")
		cutscene_1_played = true

func exit_game():
	get_tree().quit()

func pause_game():
	get_tree().paused = true
	
	var pause_menu_screen_instance = pause_menu_screen.instantiate()
	get_tree().get_root().add_child(pause_menu_screen_instance)

func continue_game():
	get_tree().paused = false

func main_menu():
	var main_menu_screen_instance = main_menu_screen.instantiate()
	get_tree().get_root().add_child(main_menu_screen_instance)

func game_over():
	if gameoverscreen_instance == null:
		gameoverscreen_instance = GameOverScreen.instantiate()
		get_tree().get_root().add_child(gameoverscreen_instance)
	
	#calls game_over() method from gameover_screen script
	gameoverscreen_instance.game_over() 

func restart_game():
	HealthManager.current_health = HealthManager.max_health
	get_tree().reload_current_scene()
	get_tree().paused = false

# will be used in the future (main menu, pause menu, etc)
func transition_to_scene(scene_path):
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file(scene_path)
