extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
onready var mob_sprite = $AnimatedSprite


func _ready():
	#position = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)
	var mob_types = mob_sprite.frames.get_animation_names()
	mob_sprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	get_parent().mob_count -= 1
	queue_free()
