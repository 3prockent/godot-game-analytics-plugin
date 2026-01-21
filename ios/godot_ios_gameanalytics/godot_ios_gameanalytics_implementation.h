//
//  godot_ios_gameanalytics_implementation.h
//

#ifndef godot_ios_gameanalytics_implementation_h
#define godot_ios_gameanalytics_implementation_h

#include "core/object/object.h"
#include "core/object/class_db.h"

class GodotIosGameanalytics : public Object {
	GDCLASS(GodotIosGameanalytics, Object);
	
	static void _bind_methods();
	
public:
	
	void hello_world();
    
    void test_simple_signal();
    void test_data_signal(const String &message);
    void test_swift_void();
    void test_swift_data();
	
	GodotIosGameanalytics();
	~GodotIosGameanalytics();
};

#endif /* godot_ios_gameanalytics_implementation_h */
