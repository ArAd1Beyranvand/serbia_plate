import 'package:plate_core/plate_core.dart';

/// Diplomatic mission codes that no layer may store.
///
/// The article's table gives the first group of a diplomatic plate as a
/// country code; `20` is Israel's, which this workspace never implements.
/// [restriction] rides on the diplomatic spec so `plate_core` refuses it in
/// the controller, the input machine, the canvas and the validator, the same
/// shape and reason as `belarus_plate`.
abstract final class SerbiaMissions {
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['20'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'code',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);
}
