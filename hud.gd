extends CanvasLayer

signal start_game		# Notified 'main' when the start button was pressed

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	

#This function is called when the player loses. It will show "Game Over" for 2 seconds, 
#then return to the title screen and, after a brief pause, show the "Start" button.
func show_game_over():
	show_message("Game over")
	
	await $MessageTimer.timeout		#Wait until the MessageTimer has counted out

	$Message.text = "Dodge the\ncreeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout	#Make a one-shot timer and wait for it to finish
	$StartButton.show()
	
	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_message_timer_timeout() -> void:
	$Message.hide()


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
