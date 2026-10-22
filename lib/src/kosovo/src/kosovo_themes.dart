import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'kosovo_colors.dart';

/// The Kosovar liveries. A rim of 4 mm on a 110 mm plate is 0.036; plates the
/// references show without a rim use 0.
abstract final class KosovoThemes {
  static PlateTheme _theme({
    required Color field,
    required Color ink,
    Color? rim,
    double rimRatio = 0.036,
    Color inactive = KosovoColors.inactiveOnLight,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: rim ?? ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: rimRatio,
    plateRadiusRatio: 0.05,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// Black on white in a black rim: private, government.
  static final PlateTheme private = _theme(field: KosovoColors.white, ink: KosovoColors.black);

  /// Black on white, no rim: moped and the UNMIK-style KS plate.
  static final PlateTheme plain = _theme(
    field: KosovoColors.white,
    ink: KosovoColors.black,
    rimRatio: 0,
  );

  /// Red on white, no rim.
  static final PlateTheme police = _theme(
    field: KosovoColors.white,
    ink: KosovoColors.policeRed,
    rimRatio: 0,
  );

  /// Red on white in a red rim.
  static final PlateTheme emergency = _theme(
    field: KosovoColors.white,
    ink: KosovoColors.emergencyRed,
  );

  /// White on blue in a thin black rim.
  static final PlateTheme customs = _theme(
    field: KosovoColors.rksBlue,
    ink: KosovoColors.white,
    rim: KosovoColors.black,
    rimRatio: 0.02,
    inactive: KosovoColors.inactiveOnDark,
  );

  /// White on blue, no rim: the UNMIK customs-guard plate.
  static final PlateTheme unmikCustoms = _theme(
    field: KosovoColors.rksBlue,
    ink: KosovoColors.white,
    rimRatio: 0,
    inactive: KosovoColors.inactiveOnDark,
  );

  /// Gold on dark green in a gold rim: Kosovo Security Force.
  static final PlateTheme military = _theme(
    field: KosovoColors.militaryGreen,
    ink: KosovoColors.militaryGold,
    rimRatio: 0.035,
    inactive: KosovoColors.inactiveOnDark,
  );

  /// White on green in a black rim.
  static final PlateTheme agriculture = _theme(
    field: KosovoColors.agricultureGreen,
    ink: KosovoColors.white,
    rim: KosovoColors.black,
    rimRatio: 0.02,
    inactive: KosovoColors.inactiveOnDark,
  );

  /// Blue on cream, no rim: trailers.
  static final PlateTheme trailer = _theme(
    field: KosovoColors.trailerField,
    ink: KosovoColors.trailerInk,
    rimRatio: 0,
  );

  /// Silver on black: diplomatic.
  static final PlateTheme diplomatic = _theme(
    field: KosovoColors.black,
    ink: KosovoColors.diplomaticInk,
    rimRatio: 0.02,
    inactive: KosovoColors.inactiveOnDark,
  );

  /// White on blue: EULEX.
  static final PlateTheme eulex = _theme(
    field: KosovoColors.eulexBlue,
    ink: KosovoColors.white,
    rimRatio: 0,
    inactive: KosovoColors.inactiveOnDark,
  );
}
