import 'package:flutter/widgets.dart';

/// The colours a Kosovar plate is printed in. Each is the modal colour of a
/// region of the flattened reference; photo-derived ones are marked
/// `// CALIBRATE` because the photo's light and cast are in them.
abstract final class KosovoColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The RKS strip at the plate's left. Artwork.
  static const Color rksBlue = Color(0xFF034EA2);

  /// The gold `RKS` printed on the strip. Artwork.
  static const Color rksGold = Color(0xFFD0A864);

  /// Police serial and `POLICE`.
  static const Color policeRed = Color(0xFFFE1517);

  /// Emergency-service ink and rim.
  static const Color emergencyRed = Color(0xFFED232B);

  /// Agriculture field.
  static const Color agricultureGreen = Color(0xFF00A651);

  /// Security Force field and its gold ink.
  static const Color militaryGreen = Color(0xFF102F21);
  static const Color militaryGold = Color(0xFFD3AD6B);

  /// Trailer plate, a photograph: cream field, blue ink. // CALIBRATE
  static const Color trailerField = Color(0xFFF4F1EB);
  static const Color trailerInk = Color(0xFF304592);

  /// Diplomatic (CD) plate, a photograph: black with silver ink. // CALIBRATE
  static const Color diplomaticInk = Color(0xFFE8F4FC);

  /// EULEX plate, a photograph: blue with white ink. // CALIBRATE
  static const Color eulexBlue = Color(0xFF204890);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
