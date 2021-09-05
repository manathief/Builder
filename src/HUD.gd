extends CanvasLayer

signal start_game

onready var l_msg: Label = $Message
onready var l_score: Label = $Score
onready var b_start: Button = $Start



func _ready():
	l_score.text = l_score.text % 0
	l_score.hide()


func show_msg(text, time):
	$MsgTimer.wait_time = time
	l_msg.text = text
	$MsgTimer.start()
	l_msg.show()
	


func msg_gameover():
	show_msg("Game Over!", 2)
	yield($MsgTimer, "timeout")
	show_msg("Dodge the\nCreeps!", 2)
	b_start.show()


func update_score(score):
	l_score.text = "Score: %s" % score


func _on_Start_pressed():
	$MsgTimer.start()
	b_start.hide()
	update_score(0)
	l_score.show()
	show_msg("Get ready!", 1)
	emit_signal("start_game")


func _on_MsgTimer_timeout():
	l_msg.hide()
