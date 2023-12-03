extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_temp_pressed():
	get_tree().change_scene_to_file("res://StartPage.tscn")


func _on_sign_up_pressed():
	if $Whole/Left/InputBoxes/PasswordInputBox.text != "" and $Whole/Left/InputBoxes/PasswordInputBox.text == $Whole/Right/InputBoxes/ConfirmPwInputBox.text and $Whole/Left/InputBoxes/UserIdInputBox.text != "" and $Whole/Right/InputBoxes/EmailInputBox.text != "":
		Global.register_args["username"] = $Whole/Left/InputBoxes/UserIdInputBox.text
		Global.register_args["email"] = $Whole/Right/InputBoxes/EmailInputBox.text
		Global.register_args['password'] = $Whole/Left/InputBoxes/PasswordInputBox.text
		#print( "userID = " , Global.register_args["username"] )
		#print( "email = " , Global.register_args["email"] )
		#print( "password = " , Global.register_args["password"] )
		Global.currentAction = 2
		var newcall = load("res://HttpRequest.tscn")
		var new = newcall.instantiate()
		add_child(new)
		new.send()
		Global.Accounts.append({"username": Global.register_args["username"], "email": Global.register_args["email"], "password": Global.register_args["password"], "nickname": ""})
		await get_tree().create_timer(1).timeout
		#get_tree().change_scene_to_file("res://LoginPage.tscn")
	else:
		print( "not yet finished" )
