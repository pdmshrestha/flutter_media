import Flutter
import UIKit

public class SwiftFlutterMediaPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "fluttermedia", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMediaPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // result("iOS " + UIDevice.current.systemVersion)
    result("[]")
  }
}
