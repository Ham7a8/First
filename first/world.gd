extends Node2D

const telScene = preload("res://saw_blade_tel.tscn")

@onready var spawn_zone = $spawnZone
@onready var timer = $Timer
@onready var label = $Label
@onready var balloon = $Balloon
@onready var part = $CPUParticles2D
@onready var pauseMenu = $"pause menu"


var pause = false

var saw_count = 0

func _ready():
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Events.balloon_poped.connect(timer.stop)
	Events.balloon_poped.connect(pause_menu)
	Events.saw_blade_added.connect(update_saw_count)
	Events.dead.connect(particals)


func pause_menu():
	pause = true
		
	#pauseMenu = !pauseMenu

func update_saw_count():
	saw_count += 1
	label.text = "Blades\n" + str(saw_count)
	
	
	
func particals():
	part.position = balloon.position
	part.emitting = true
	
func _process(_delta):
	if Input.is_action_just_pressed("r_key"):
		get_tree().reload_current_scene()
		
		
	if pause:
		pauseMenu.show()
	
	else:
		pauseMenu.hide()
	
func _on_timer_timeout():
	var sawtel = telScene.instantiate()
	var rect = spawn_zone.get_global_rect()
	var saw_x = randf_range(rect.position.x, rect.end.x)
	var saw_y = randf_range(rect.position.y, rect.end.y)
	sawtel.position = Vector2(saw_x, saw_y)
	get_tree().current_scene.add_child(sawtel)


