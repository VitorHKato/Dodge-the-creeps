extends RigidBody2D

func _ready() -> void:
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()		#["walk", "swim", "fly"]
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])		#Sort a random animation (0, 1 or 2) 


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()		#Remove when out of the screen
