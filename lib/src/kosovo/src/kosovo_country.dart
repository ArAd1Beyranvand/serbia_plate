import 'package:plate_core/plate_core.dart';

import 'kosovo_colors.dart';

/// Kosovo as a `PlateCountry`. The RKS strip is painted by each spec's
/// background and its letters are labels, so no spec prints a panel and
/// [captionLines] is empty; this carries the flag for hosts that list
/// countries.
///
/// The flag is an SVG, not a `PlateDrawing`: the gold map of the country is
/// an irregular outline that no const shape draws.
/// Source: Commons `Flag_of_Kosovo.svg`.
abstract final class KosovoCountry {
  static const PlateCountry kosovo = PlateCountry(
    code: 'xk',
    captionLines: <String>[],
    panelColor: KosovoColors.rksBlue,
    panelTextColor: KosovoColors.rksGold,
    flagAspectRatio: 7 / 5,
    flag: SvgPlateAsset('assets/kosovo/icons/flag_of_kosovo.svg', package: 'serbia_plate'),
  );
}
