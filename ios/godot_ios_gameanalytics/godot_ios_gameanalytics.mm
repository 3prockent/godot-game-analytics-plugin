//
//  godot_ios_gameanalytics.mm
//

#import <Foundation/Foundation.h>

#import "godot_ios_gameanalytics.h"
#import "godot_ios_gameanalytics_implementation.h"

#import "core/config/engine.h"


GodotIosGameanalytics *plugin;

void godot_ios_gameanalytics_init() {
	NSLog(@"init plugin");

	plugin = memnew(GodotIosGameanalytics);
	Engine::get_singleton()->add_singleton(Engine::Singleton("GodotIosGameanalytics", plugin));
}

void godot_ios_gameanalytics_deinit() {
	NSLog(@"deinit plugin");
	
	if (plugin) {
	   memdelete(plugin);
   }
}
