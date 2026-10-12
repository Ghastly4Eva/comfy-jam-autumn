extends CharacterBody2D
@onready var anims_ref = $AnimatedSprite2D
var timer_ref

const SPEED = 100.0


func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * SPEED
		if velocity.x > 0: 
			anims_ref.play("Right_Walk")
		elif velocity.x < 0:
			anims_ref.play("Left_Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	var directiony := Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * SPEED
		if velocity.y > 0: 
			anims_ref.play("Down_Walk")
		elif velocity.y < 0:
			anims_ref.play("Up_Walk")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if not velocity.x and not velocity.y and (anims_ref.get_animation() != "idle" or not anims_ref.is_playing()):
		anims_ref.stop()
		timer_ref = Timer.new()
		$timers.add_child(timer_ref)
		timer_ref.start()
		await timer_ref.timeout
		anims_ref.play("idle")
	else:
		if is_instance_valid(timer_ref):
			for timers in $timers.get_children():
				timers.free()
		
	move_and_slide()
