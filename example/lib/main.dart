import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:battery_status/battery_status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _batteryLevel = 'Battery level: unknown.';
  final _batteryStatusPlugin = BatteryStatus();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battery status plugin'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 24,),
              Text('Running on: $_platformVersion\n'),
              const SizedBox(height: 24,),
              Text(
                _batteryLevel,
                style: const TextStyle(fontSize: 18,),
              ),
              const SizedBox(height: 24,),
              ElevatedButton(
                onPressed: _getBatteryLevel,
                child: const Text('Get Battery Level'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await _batteryStatusPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int? result = await _batteryStatusPlugin.getBatteryLevel();
      batteryLevel = result != null ? 'Battery level: $result%.' : 'Unknown battery level';
    } on PlatformException catch (e) {
      if (e.code == 'NO_BATTERY') {
        batteryLevel = 'No battery.';
      } else {
        batteryLevel = 'Failed to get battery level.';
      }
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

}
