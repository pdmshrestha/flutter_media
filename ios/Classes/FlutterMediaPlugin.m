#import "FlutterMediaPlugin.h"
#if __has_include(<flutter_media/flutter_media-Swift.h>)
#import <flutter_media/flutter_media-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_media-Swift.h"
#endif

@implementation FlutterMediaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMediaPlugin registerWithRegistrar:registrar];
}
@end
