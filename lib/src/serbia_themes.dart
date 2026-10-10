import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'serbia_colors.dart';

/// One ink on one field with a frame in the ink's colour, except where the
/// photo shows another: the diplomatic frame is orange, the military plate has
/// none.
///
/// The frame is about 3 of the 110 plate height in the flats (0.03); the
/// corner arc about 0.07. Neither is measured more closely than that.
abstract final class SerbiaThemes {
  static final PlateTheme private = _theme(
    SerbiaColors.white,
    SerbiaColors.black,
  );
  static final PlateTheme taxi = _theme(SerbiaColors.white, SerbiaColors.black);
  static final PlateTheme trailer = _theme(
    SerbiaColors.white,
    SerbiaColors.black,
  );
  static final PlateTheme police = _theme(
    SerbiaColors.policeBlue,
    SerbiaColors.white,
    frame: SerbiaColors.black,
  );
  static final PlateTheme diplomatic = _theme(
    SerbiaColors.black,
    SerbiaColors.diplomaticOrange,
  );
  static final PlateTheme military = _theme(
    SerbiaColors.white,
    SerbiaColors.black,
    border: 0,
  );
  static final PlateTheme oldtimer = _theme(
    SerbiaColors.white,
    SerbiaColors.black,
  );
  static final PlateTheme agricultural = _theme(
    SerbiaColors.agriculturalField,
    SerbiaColors.agriculturalInk,
  );
  static final PlateTheme moped = _theme(
    SerbiaColors.mopedField,
    SerbiaColors.mopedInk,
  );
  static final PlateTheme motorcycle = _theme(
    SerbiaColors.white,
    SerbiaColors.black,
  );
}

PlateTheme _theme(
  Color field,
  Color ink, {
  Color? frame,
  double border = 0.03,
}) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  inactive: SerbiaColors.inactive,
  borderWidthRatio: border,
  plateRadiusRatio: 0.07,
).copyWith(plateBorder: frame ?? ink);
