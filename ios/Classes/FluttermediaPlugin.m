#import "FlutterMediaPlugin.h"
#if __has_include(<fluttermedia/fluttermedia-Swift.h>)
#import <fluttermedia/fluttermedia-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fluttermedia-Swift.h"
#endif

@implementation FlutterMediaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMediaPlugin registerWithRegistrar:registrar];
}
@end
