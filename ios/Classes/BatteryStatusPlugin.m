#import "BatteryStatusPlugin.h"
#if __has_include(<battery_status/battery_status-Swift.h>)
#import <battery_status/battery_status-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "battery_status-Swift.h"
#endif

@implementation BatteryStatusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBatteryStatusPlugin registerWithRegistrar:registrar];
}
@end
