//
//  godot_ios_gameanalytics_implementation.mm
//

#import <Foundation/Foundation.h>
#import "godot_ios_gameanalytics_implementation.h"

#import "GameAnalytics/GameAnalytics.h"

void GodotIosGameanalytics::_bind_methods() {
    ClassDB::bind_method(D_METHOD("init", "gameKey", "secretKey"), &GodotIosGameanalytics::init);
    ClassDB::bind_method(D_METHOD("set_enabled_verbose_log", "flag"), &GodotIosGameanalytics::set_enabled_verbose_log);
    ClassDB::bind_method(D_METHOD("set_enabled_info_log", "flag"), &GodotIosGameanalytics::set_enabled_info_log);
    ClassDB::bind_method(D_METHOD("set_enabled_event_submission", "flag"), &GodotIosGameanalytics::set_enabled_event_submission);
    ClassDB::bind_method(D_METHOD("add_impression_event", "adNetworkVersion", "data"), &GodotIosGameanalytics::add_impression_event);
}

GodotIosGameanalytics::GodotIosGameanalytics() {
    NSLog(@"[GodotGameAnalytics] Plugin initialized");
}

GodotIosGameanalytics::~GodotIosGameanalytics() {
    NSLog(@"[GodotGameAnalytics] Plugin deinitialized");
}

void GodotIosGameanalytics::init(const String &game_key, const String &secret_key) {
    // Конвертация строк Godot -> NSString
    NSString *nsGameKey = [NSString stringWithUTF8String:game_key.utf8().get_data()];
    NSString *nsSecretKey = [NSString stringWithUTF8String:secret_key.utf8().get_data()];
    
    [GameAnalytics initializeWithGameKey:nsGameKey gameSecret:nsSecretKey];
    
    NSLog(@"[GodotGameAnalytics] Initialized with Key: %@", nsGameKey);
}

void GodotIosGameanalytics::set_enabled_verbose_log(bool flag) {
    [GameAnalytics setEnabledVerboseLog:flag];
}

void GodotIosGameanalytics::set_enabled_info_log(bool flag) {
    [GameAnalytics setEnabledInfoLog:flag];
}

void GodotIosGameanalytics::set_enabled_event_submission(bool flag) {
    [GameAnalytics setEnabledEventSubmission:flag];
    NSLog(@"[GodotGameAnalytics] Event submission enabled: %s", flag ? "true" : "false");
}

void GodotIosGameanalytics::add_impression_event(const String &ad_network_version, const Dictionary &data) {
    NSString *nsAdNetworkVersion = [NSString stringWithUTF8String:ad_network_version.utf8().get_data()];
    
    NSMutableDictionary *impressionData = [[NSMutableDictionary alloc] init];
    Array keys = data.keys();
    
    for (int i = 0; i < keys.size(); i++) {
        Variant key = keys[i];
        Variant value = data[key];
        
        String keyStr = key.operator String();
        NSString *nsKey = [NSString stringWithUTF8String:keyStr.utf8().get_data()];
        
        id nsValue = nil;
        
        if (value.get_type() == Variant::INT) {
            nsValue = [NSNumber numberWithInt:(int)value];
        }
        else if (value.get_type() == Variant::FLOAT) {
            nsValue = [NSNumber numberWithDouble:(double)value];
        }
        else if (value.get_type() == Variant::BOOL) {
            nsValue = [NSNumber numberWithBool:(bool)value];
        }
        else {
            String valStr = value.operator String();
            nsValue = [NSString stringWithUTF8String:valStr.utf8().get_data()];
        }
        
        if (nsKey && nsValue) {
            [impressionData setValue:nsValue forKey:nsKey];
        }
    }
    
    [GameAnalytics addImpressionMaxEventWithAdNetworkVersion:nsAdNetworkVersion impressionData:impressionData];
    
    NSLog(@"[GodotGameAnalytics] Sent ad_impression: %@", impressionData);
}
