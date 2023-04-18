extends Area2D

signal hit		#Cria um sinal

@export var speed = 400
var screen_size 


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity = Vector2.ZERO							#Player movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed			#Normalized to prevent from moving faster diagonally.
		$AnimatedSprite2D.play()						#get_node("AnimatedSprite2D").play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)	#clamp() prevent the player to leave the screen
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0		#Flip the image horizontally
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide()		#Player disappears after being hit.
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)	#Disable player's collision shape when it's safe.
	
	
#Restart the player
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
