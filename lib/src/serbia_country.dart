import 'package:plate_core/plate_core.dart';

import 'serbia_colors.dart';

/// Serbia as a `PlateCountry`: only the blue side band. `SRB` is a
/// [PlateLabel] on each spec, so [captionLines] is empty and there is no flag.
abstract final class SerbiaCountry {
  static const PlateCountry serbia = PlateCountry(
    code: 'rs',
    captionLines: <String>[],
    panelColor: SerbiaColors.band,
    panelTextColor: SerbiaColors.white,
  );
}
