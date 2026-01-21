extends Node

var ga

const GAME_KEYS = {
	"Android": "9553b032303baf73d1e33cb244dceea9",
	"iOS"    : "d4ce8290279e895055a03e35517c0cc9",
}

const SECRET_KEYS = {
	"Android": "fde1001d25152aa7fe49c3328a9aac49d1259f51",
	"iOS"    : "892a946c2b83fbd5b26a377537d6c3a2a0b9636a",
}

const _android_plugin_name : String = "GodotGameAnalytics"
const _ios_plugin_name : String = "GodotIosGameanalytics"

var platform_os = OS.get_name()


func _ready():
	if Engine.has_singleton(_android_plugin_name):
		ga = Engine.get_singleton(_android_plugin_name)
	if Engine.has_singleton(_ios_plugin_name):
		ga = Engine.get_singleton(_ios_plugin_name)
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
	
	
func log_applovin_impression(ad_info : Object):
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


class AdInfo:
	var ad_unit_identifier: String
	var ad_format: String
	var network_name: String
	var network_placement: String
	var placement: String
	var creative_identifier: String
	var revenue: float
	var revenue_precision: String
	var dsp_name: String


func _log(log_text : String) -> void:
	print("[GameAnalyticsManager]: ", log_text)
