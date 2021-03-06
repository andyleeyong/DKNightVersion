# -*- coding: utf-8 -*-

module ObjcClassColorCategory
	def interface_class_string(property)
		<<-OBJECT_C
//
//  #{name}+#{property.cap_name}.h
//  #{name}+#{property.cap_name}
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#{interface_import_string}

#{interface_string(property)}
#{interface_property_string(property)}
@end
		OBJECT_C
	end

	def implementation_class_string(property)
		<<-OBJECT_C
//
//  #{name}+#{property.cap_name}.m
//  #{name}+#{property.cap_name}
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#{implementation_import_string(property)}
#{implementation_interface_string(property)}
#{implementation_string(property)}
		OBJECT_C
	end

private

	def interface_import_string
		"#import <UIKit/UIKit.h>"
	end

	def interface_string(property)
		<<-OBJECT_C
@interface #{name} (#{property.cap_name})
		OBJECT_C
	end

	def interface_property_string(property)
		s = <<-OBJECT_C
/**
 Set this property when switch to night version #{name[2..-1].downcase} #{property.name.downcase} turns to this color.
*/
@property (nonatomic, strong) #{property.type} *night#{property.cap_name};

/**
 #{name[2..-1].capitalize} #{property.name.downcase} in normal version.
*/
@property (nonatomic, strong, readonly) #{property.type} *normal#{property.cap_name};

		OBJECT_C
	end


	def implementation_import_string(property)
		<<-OBJECT_C
#import \"#{name}+#{property.name}.h\"
#import "DKNightVersionManager.h"
#import \"objc/runtime.h\"
		OBJECT_C
	end

	def implementation_interface_string(property)
		<<-OBJECT_C
@interface #{name} ()

@property (nonatomic, strong) #{property.type} *normal#{property.cap_name};

@end
		OBJECT_C
	end

	def implementation_static_char_string(property)
		<<-OBJECT_C
static char *night#{property.cap_name}Key;
static char *normal#{property.cap_name}Key;
		OBJECT_C
	end

	def implementation_string(property)
		<<-OBJECT_C
@implementation #{name} (#{property.cap_name})

#{implementation_static_char_string(property)}
#{property.method_string}
@end
		OBJECT_C
	end

end