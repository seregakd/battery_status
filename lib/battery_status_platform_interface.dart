import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'battery_status_method_channel.dart';

abstract class BatteryStatusPlatform extends PlatformInterface {
  /// Constructs a BatteryStatusPlatform.
  BatteryStatusPlatform() : super(token: _token);

  static final Object _token = Object();

  static BatteryStatusPlatform _instance = MethodChannelBatteryStatus();

  /// The default instance of [BatteryStatusPlatform] to use.
  ///
  /// Defaults to [MethodChannelBatteryStatus].
  static BatteryStatusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BatteryStatusPlatform] when
  /// they register themselves.
  static set instance(BatteryStatusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<int?> getBatteryLevel() {
    throw UnimplementedError('BatteryLevel() has not been implemented.');
  }
}
