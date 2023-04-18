extends Node

@export var mob_scene: PackedScene
var score


func _ready():
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.show_game_over()
	
	$Music.stop()
	$DeathSound.play()
	
	
func new_game():
	score = 0 
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	get_tree().call_group("mobs", "queue_free")		#Node -> Groups -> created 'mobs' groups
	
	$Music.play()


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1

	$HUD.update_score(score)


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()		#Create a new instance of the Mob scene
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()			#Choose a random location on Path2D
	
	var direction = mob_spawn_location.rotation + PI / 2		#Set the mob direction perpendicular to the path direction
	
	mob.position = mob_spawn_location.position			#Set the mob's position to a random location
	
	direction += randf_range(-PI / 4, PI / 4)			#Add some randomness to the direction
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)		#Choose the velocity for the mob
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)			#Spawn the mob by adding it to the main scene
