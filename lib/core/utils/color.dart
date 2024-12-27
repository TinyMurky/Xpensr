import 'package:flutter/material.dart';

/// Change [Color] lightness from -1 ~ 1, below 0 means darker
Color changeColorLightness({
  required Color color,
  required double amount,
}) {
  assert(amount >= -1.0 && amount <= 1.0);

  // Ref: https://stackoverflow.com/questions/58360989/programmatically-lighten-or-darken-a-hex-color-in-dart

  /// HSL stand for `Hue`, `Saturation`, `Lightness`
  final hsl = HSLColor.fromColor(color);
  final hslWithNewLightness =
      hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslWithNewLightness.toColor();
}

Color makeColorMorePinky({
  required Color color,
  required double lightenDegree,
}) {
  assert(lightenDegree >= 0);

  final hsl = HSLColor.fromColor(color);
  // increase Saturation, adjust lightness
  final pinkyColor = hsl
    .withSaturation((hsl.saturation * 0.7).clamp(0.0, 1.0))
    .withLightness((hsl.lightness * lightenDegree).clamp(0.0, 1.0));
  return pinkyColor.toColor();
}
