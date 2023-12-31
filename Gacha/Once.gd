extends TouchScreenButton

var cardTemp
var press = 0
var CardInfo
var newcall
var new

func _on_pressed():
	if Global.GemAmount >= 5:
		$"..".visible = false
		$"../../TenTimes".visible = false
		$"../../CoinAndDiamond".visible = false
		$"../../Name".visible = false
		$"../../CardSample".visible = false
		$"../../Possibility".visible = false
		$"../../CardSample/Timer".stop()
		$"../../List".visible = false
		$"../../Transition".visible = true
		$"../../Transition".play("transition")
		press = 1
		Global.response["status"] = ""
		Global.gacha_args["username"] = Global.Account["username"]
		Global.gacha_args["draws"] = 1
		Global.gacha_args["cookies"] = Global.Account["cookies"]
		Global.currentAction = 7
		newcall = load("res://Global/HttpRequest.tscn")
		new = newcall.instantiate()
		add_child(new)
		new.send()
		
		await get_tree().create_timer(2).timeout
	else:
		$"../../Notice".visible = true
		$"../../Notice/Label".text = "Not enough diamonds"
		await get_tree().create_timer(2).timeout
		$"../../Notice".visible = false
	
func _on_transition_animation_finished():
	if press == 1:
		$"../../Transition".visible = false
		$"../../Back".visible = false
		
		if Global.response["status"] == "Successful":
			remove_child(new)
			var cardPosition = Vector2( 0, 0)
			Global.storage[int(Global.response["1"]-1)] += 1
			var CardInfo = Global.Card[int(Global.response["1"]-1)]
			if CardInfo[0] == "Tool":
				cardPosition = Vector2(400,120)
			else:
				cardPosition = Vector2(0,0)

			Global.currentCard = int(Global.response["1"]-1)
			cardTemp = Global.CardUnit.instantiate()
			cardTemp.position = cardPosition
			cardTemp.visible = false
			if CardInfo[0] == "Tool":
				cardTemp.scale *= Vector2(300,300) / cardTemp.size
			$"../../Cards".add_child(cardTemp)
			cardTemp.visible = true
			Global.GemAmount -= 5
			if Global.currentCard == 0:
				$"../../Continue/ContinueLabel".add_theme_color_override("font_color",Color(0.871, 0.852, 0.734))
			else:
				$"../../Continue/ContinueLabel".add_theme_color_override("font_color",Color(0.451, 0.388, 0.341))
		else:
			remove_child(new)
			$"../../Transition".visible = true
			$"../../Transition".play("transition")
			new = newcall.instantiate()
			add_child(new)
			new.send()
			
			await get_tree().create_timer(2).timeout
		''''''
		$"../../Continue".visible = true


func _on_continue_pressed():
	if press == 1:
		cardTemp.queue_free()
		press = 0
	$"..".visible = true
	$"../../Back".visible = true
	$"../../CoinAndDiamond".visible = true
	$"../../Name".visible = true
	
	$"../../Continue".visible = false
	$"../../Possibility".visible = true
	Global.currentCard = Global.RareCardAmount - 1
	CardInfo = Global.Card[Global.currentCard]
	var CardImg = str( "res://png/Gacha/big_" , CardInfo[1] , ".png" )
	$"../../CardSample/Card".texture = load(CardImg)
	$"../../CardSample".visible = true
	$"../../Possibility".text = str(float(Global.Pcard[Global.currentCard]-Global.Pcard[Global.currentCard-1])*100.0/Global.Pcard[Global.CardAmount-1])+"%"
	$"../../CardSample/Timer".start()
	$"../../List".visible = true





