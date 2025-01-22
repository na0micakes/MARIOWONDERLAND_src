extends Node

var coins

signal gained_coins(int)
# https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-structure
# ^ (not all fields are allowed by Discord)

const APPLICATION_ID: int = 1262259955323375656 

var discord := DiscordRPC.new()

func _ready() -> void:
	add_child(discord)

	discord.rpc_ready.connect(
		func(user: Dictionary):
			discord.update_presence({
				details = "test build",
				state = "testmap001",
				timestamps = {
					start = int(Time.get_unix_time_from_system())
				},
				assets = {
					large_image = "mariowonderland_rpc",
				}
			})
	)

	discord.establish_connection(APPLICATION_ID)

	process_mode = Node.PROCESS_MODE_PAUSABLE

	$transition/AnimationPlayer.play("fadeIn")
	$transition/AnimationPlayer.speed_scale = 2
	
func gain_coins(coins_gained):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)
