extends Area2D

signal is_hit

#access child
onready var anim: AnimatedSprite = $AnimatedSprite
#declare member variables
export var speed = 400
var screen_size
var sprite_size


func _ready():
	#viewport rect is set in proj settings
	screen_size = get_viewport_rect().size
	sprite_size = anim.frames.get_frame("walk" , 0).get_size()
	hide()


func _process(delta):
	var direction = Vector2.ZERO
	var velocity = Vector2.ZERO
	#check for input
	direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	#movement direction detect
	if direction.length() > 0:
		velocity = direction * speed
		#play animation
		anim.play()
	else:
		anim.stop()
	#update position
	position += velocity * delta
	#bound player movement to screen
	position.x = clamp(position.x, sprite_size.x / 4, screen_size.x - sprite_size.x / 4)
	position.y = clamp(position.y, sprite_size.y / 4, screen_size.y - sprite_size.y / 4)
	#update animation
	if velocity.x != 0:
		anim.animation = "walk"
		anim.flip_v = false
		anim.flip_h = velocity.x < 0
	elif velocity.y != 0:
		anim.animation = "up"
		anim.flip_v = velocity.y > 0


#anytime a body enters player, gets triggered
func _on_Player_body_entered(_body):
	emit_signal("is_hit")
	hide()
	#access the collisionshape child of player [disabled = true]
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)



