import Flutter
import UIKit

public class SwiftBatteryStatusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "battery_status", binaryMessenger: registrar.messenger())
    let instance = SwiftBatteryStatusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if (call.method == "getPlatformVersion") {
          result("iOS " + UIDevice.current.systemVersion)
      } else if (call.method == "getBatteryLevel") {
          self.getBatteryLevel(result: result)
      } else {
          result(FlutterMethodNotImplemented)
      }
  }
    
    private func getBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      guard device.batteryState != .unknown  else {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery info unavailable",
                            details: nil))
        return
      }
      result(Int(device.batteryLevel * 100))
    }
}
