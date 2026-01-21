//
//  godot_ios_gameanalytics_implementation.h
//

#ifndef godot_ios_gameanalytics_implementation_h
#define godot_ios_gameanalytics_implementation_h

#include "core/object/object.h"
#include "core/object/class_db.h"

#include "core/variant/variant.h"
#include "core/variant/dictionary.h"

class GodotIosGameanalytics : public Object {
    GDCLASS(GodotIosGameanalytics, Object);
    
    static void _bind_methods();
    
public:
    void init(const String &game_key, const String &secret_key);
    void set_enabled_verbose_log(bool flag);
    void set_enabled_info_log(bool flag);
    void set_enabled_event_submission(bool flag);
    void add_impression_event(const String &ad_network_version, const Dictionary &data);
    
    GodotIosGameanalytics();
    ~GodotIosGameanalytics();
};

#endif /* godot_ios_gameanalytics_implementation_h */
