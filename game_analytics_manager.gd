extends Node

var ga

const GAME_KEYS = {
	"Android": "9553b032303baf73d1e33cb244dceea9",
	"iOS"    : "test",
}

const SECRET_KEYS = {
	"Android": "fde1001d25152aa7fe49c3328a9aac49d1259f51",
	"iOS"    : "test",
}

var platform_os = OS.get_name()

#func _notification(what):
	#if what == NOTIFICATION_WM_CLOSE_REQUEST :
		#ga.onQuit()

func _ready():
	if Engine.has_singleton("GodotGameAnalytics"):
		ga = Engine.get_singleton("GodotGameAnalytics")
	if ga == null:
		printerr("Error: GameAnalytics not found!")

func init():	
	_log("Init GodotGameAnalytics")
	ga.init(GAME_KEYS[platform_os], SECRET_KEYS[platform_os])

func set_verbose_log(is_debug : bool = true) -> void:
	if not _is_plugin_ready():
		return
	ga.set_enabled_verbose_log(is_debug)
	
	
func set_info_log(is_debug : bool = true) -> void:
	if not _is_plugin_ready():
		return
	ga.set_enabled_info_log(is_debug)
	

func set_enabled_event_submission(is_to_send : bool = true) -> void:
	if not _is_plugin_ready():
		return
	_log("set enabled event submission to "+str(is_to_send))
	ga.set_enabled_event_submission(is_to_send)
	
	
func log_applovin_impression(ad_info : AppLovinMAX.AdInfo):
	_log("send ad impression")
	ga.add_impression_event(
		"1.0.0",
		{
			#"country" :"",
			"network_name":ad_info.network_name,
			"adunit_id":ad_info.ad_unit_identifier,
			"adunit_format":ad_info.ad_format,
			"placement":ad_info.network_placement,
			"creative_id":ad_info.creative_identifier,
			"revenue":ad_info.revenue
		}
	)
	

func _is_plugin_ready() -> bool:
	if not ga:
		_log("ERROR: GameAnalytics plugin is not initialized. Call init() first or check plugin setup.")
		return false
	return true
	

func _log(log_text : String) -> void:
	print("[GameAnalyticsManager]: ", log_text)
