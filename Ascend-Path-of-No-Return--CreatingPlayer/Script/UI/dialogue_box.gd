extends CanvasLayer

var text_file : String = "res://Dialogue//dialogue.json"
var scene_text = {}
var selected_text = []
var in_progress = false
var current_index = 0

func _ready():
	$NinePatchRect.hide()
	scene_text = load_text()

func load_text():
	var file = FileAccess.open(text_file, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(content)
	
func on_display_dialogue(text_key : String):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		$NinePatchRect.show()
		in_progress = true
		current_index = 0
		selected_text = scene_text.get(text_key, [])
		show_text()
	
func show_text():
	if current_index < selected_text.size():
		var line = selected_text[current_index]
		$NinePatchRect/Name.text = line["name"]
		$NinePatchRect/Text.text = line["text"]
		$NinePatchRect.show()
		current_index += 1
	else:
		hide_dialogue()
	
func next_line():
	if current_index < selected_text.size():
		var line = selected_text[current_index]
		$NinePatchRect/Name.text = line["name"]
		$NinePatchRect/Text.text = line["text"]
		$NinePatchRect.show()
		current_index += 1
	else:
		hide_dialogue()
	
func hide_dialogue():
	$NinePatchRect.hide()
	current_index = 0
	in_progress = false
	get_tree().paused = false
