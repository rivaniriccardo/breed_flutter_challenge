import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

DeviceBuilder getDefaultBuilder(Widget child) {
  loadAppFonts();

  return DeviceBuilder()
    ..overrideDevicesForAllScenarios(
      devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ],
    )
    ..addScenario(
      widget: child,
    );
}
