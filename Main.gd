extends Node

export var Mob: PackedScene #loaded in inspector
var score: int
var mob_count: int = 0

func _ready():
	randomize()
	$Music.set_volume_db(-20)
	$Death.set_volume_db(-20)


func _on_Player_is_hit():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.msg_gameover()
	$Music.stop()
	$Death.play()
	get_tree().call_group("mobs", "queue_free")


func new_game():
	score = 0
	$Music.play()
	$Player.start($StartPos.position)
	$StartTimer.start()


func _on_MobTimer_timeout():
	#create mob instance
	var mob = Mob.instance()
	if (mob_count < 6):
		add_child(mob)
		mob_count += 1
	#set spawn location
	$MobPath/MobSpawn.unit_offset = randf()
	mob.position = $MobPath/MobSpawn.position
	mob.rotation = $MobPath/MobSpawn.rotation + deg2rad(90) + rand_range(-deg2rad(45), deg2rad(45))
	#set mob motion path speed + rotated direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(mob.rotation)


func _on_ScoreTimer_timeout():
	score += 10
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_HUD_start_game():
	new_game()
