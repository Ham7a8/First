extends CharacterBody2D

@onready var hurt_box = $HurtBox


const mac_speed = 100
const accel = 1200
const friction = 300

var input = Vector2.ZERO

var speed = 400  # Adjust movement speed as needed


func _physics_process(delta):
	player_movement(delta)
	#var mouse_position = get_global_mouse_position()
	#position = mouse_position
	
func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	
	else :
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(mac_speed)
 
	move_and_slide()
	


func _on_hurt_box_body_entered(_body):
	Events.balloon_poped.emit()
	queue_free()  
