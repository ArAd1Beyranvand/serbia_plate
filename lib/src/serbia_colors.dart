import 'package:flutter/widgets.dart';

/// Colours of the Serbian plates, sampled from the flattened photos (modal
/// pixel of the region, colour-balanced).
///
/// White and black are exact where the artwork is vector (registration, taxi,
/// trailer). The historic and motorcycle photos read a blue-tinted white:
/// that is the camera, the article says white, so they use [white]. The
/// agricultural and moped fields and their inks are photographed and carry
/// their photo's lighting.
abstract final class SerbiaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color band = Color(0xFF1145EA);

  static const Color policeBlue = Color(0xFF013F80);
  static const Color diplomaticOrange = Color(0xFFFFA500);

  static const Color agriculturalField = Color(0xFF0DEFC9);
  static const Color agriculturalInk = Color(0xFF293744);
  static const Color mopedField = Color(0xFFFFB627);
  static const Color mopedInk = Color(0xFF686062);

  static const Color inactive = Color(0xFFB0B0B0);
}
