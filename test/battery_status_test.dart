import 'package:flutter_test/flutter_test.dart';
import 'package:battery_status/battery_status.dart';
import 'package:battery_status/battery_status_platform_interface.dart';
import 'package:battery_status/battery_status_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBatteryStatusPlatform
    with MockPlatformInterfaceMixin
    implements BatteryStatusPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int?> getBatteryLevel() => Future.value(90);
}

void main() {
  final BatteryStatusPlatform initialPlatform = BatteryStatusPlatform.instance;

  test('$MethodChannelBatteryStatus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBatteryStatus>());
  });

  test('getPlatformVersion', () async {
    BatteryStatus batteryStatusPlugin = BatteryStatus();
    MockBatteryStatusPlatform fakePlatform = MockBatteryStatusPlatform();
    BatteryStatusPlatform.instance = fakePlatform;

    expect(await batteryStatusPlugin.getPlatformVersion(), '42');
  });
}
