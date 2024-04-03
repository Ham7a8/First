extends Node2D

@onready var arrow = $Arrow
@onready var timer = $Timer
@onready var spawn_sfx = $spawn_sfx
@onready var saw_blade_tel = $"."

const sawScene = preload("res://saw_balde.tscn")

var direction = Vector2.RIGHT.rotated(randf_range(0,TAU))



# Called when the node enters the scene tree for the first time.
func _ready():
	arrow.rotation = direction.angle()
	Events.balloon_poped.connect(timer.stop)
	spawn_sfx.pitch_scale = randf_range(0.8, 1.2)
	spawn_sfx.play()

	

func _on_timer_timeout():
	Events.saw_blade_added.emit()
	var saw = sawScene.instantiate()
	saw.position = position
	saw.linear_velocity = direction * 50
	get_tree().current_scene.add_child(saw)

	queue_free()
	

