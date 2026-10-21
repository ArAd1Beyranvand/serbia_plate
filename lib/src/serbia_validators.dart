import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

/// Judges a Serbian plate by its keyed groups; which groups exist depends on
/// the design, read off the spec id. Reports, never bars a keystroke.
///
/// - `rs.private`: `region` (two letters) · `digits` (3–4) · `letters` (two,
///   X allowed): `BG 1234-EC`.
/// - `rs.taxi`: `region` · five digits · `TX`; `rs.trailer`: two letters,
///   three digits, `region`.
/// - `rs.police`: `П`, three digits, three digits; `rs.military`: a letter and
///   four digits.
/// - `rs.diplomatic`: area code, a two-digit country code (the three-digit
///   codes do not fit the plate), a series letter `A`/`M`/`P`, three digits
///   and a two-digit tail. The refused code `20` is reported first by
///   [GatedPlateValidator].
/// - two-row plates: `region`, then two and three characters (`OT` and three
///   digits; two digits and three letters on agricultural; two and three
///   digits on moped and motorcycle).
///
/// The article's region table is cut off after `LO`, so any two letters of the
/// region alphabet are accepted rather than a fixed list.
class SerbiaValidator extends GatedPlateValidator {
  const SerbiaValidator();

  @override
  String get gateGroup => 'region';

  static const String reasonRegion = 'The area code is two letters, e.g. BG.';
  static const String reasonDigits = 'Check the number of digits.';
  static const String reasonLetters = 'Check the series letters.';

  static bool _inAlphabet(String v, int n, PlateAlphabet alphabet) =>
      v.length == n && v.split('').every(alphabet.characters.contains);

  static bool _letters(String v, int n) =>
      _inAlphabet(v, n, SerbiaAlphabets.letters);

  PlateValidation _ok(bool ok, String reason) =>
      ok ? const PlateValidation.valid() : PlateValidation.invalid(reason);

  @override
  PlateValidation validate(PlateEntry entry) {
    final String id = entry.spec.id;
    if (id == 'rs.police' || id == 'rs.military' || id == 'rs.diplomatic') {
      return restrictionVerdict(entry) ?? _judgeSpecial(entry, id);
    }
    return super.validate(entry);
  }

  PlateValidation _judgeSpecial(PlateEntry entry, String id) {
    switch (id) {
      case 'rs.police':
        return _ok(
          isDigitsOfLength(entry.group('a'), 3) &&
              isDigitsOfLength(entry.group('b'), 3),
          reasonDigits,
        );
      case 'rs.military':
        return _ok(
          _letters(entry.group('letter'), 1) &&
              isDigitsOfLength(entry.group('digits'), 4),
          reasonDigits,
        );
      default:
        return _ok(
          isDigitsOfLength(entry.group('code'), 2) &&
              isDigitsOfLength(entry.group('serial'), 3) &&
              (entry.group('tail').isEmpty ||
                  isDigitsOfLength(entry.group('tail'), 2)),
          reasonDigits,
        );
    }
  }

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_inAlphabet(entry.group('region'), 2, SerbiaAlphabets.regionLetters)) {
      return const PlateValidation.invalid(reasonRegion);
    }
    switch (entry.spec.id) {
      case 'rs.private':
        final String d = entry.group('digits');
        return _ok(
          (isDigitsOfLength(d, 3) || isDigitsOfLength(d, 4)) &&
              _letters(entry.group('letters'), 2),
          reasonDigits,
        );
      case 'rs.taxi':
        return _ok(isDigitsOfLength(entry.group('digits'), 5), reasonDigits);
      case 'rs.trailer':
        return _ok(
          _letters(entry.group('letters'), 2) &&
              isDigitsOfLength(entry.group('digits'), 3),
          reasonDigits,
        );
      case 'rs.oldtimer':
        return _ok(
          entry.group('a') == 'OT' && isDigitsOfLength(entry.group('b'), 3),
          reasonDigits,
        );
      case 'rs.agricultural':
        return _ok(
          isDigitsOfLength(entry.group('a'), 2) &&
              _letters(entry.group('b'), 3),
          reasonLetters,
        );
      default:
        return _ok(
          isDigitsOfLength(entry.group('a'), 2) &&
              isDigitsOfLength(entry.group('b'), 3),
          reasonDigits,
        );
    }
  }
}
