import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'battery_status_platform_interface.dart';

/// An implementation of [BatteryStatusPlatform] that uses method channels.
class MethodChannelBatteryStatus extends BatteryStatusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('battery_status');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> getBatteryLevel() async {
    final int? batteryLevel = await methodChannel.invokeMethod('getBatteryLevel');
    return batteryLevel;
  }

}
