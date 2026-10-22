import 'package:plate_core/plate_core.dart';

/// The district codes opening a plate: the article's table, 01 Pristina to 07
/// Gjakova.
abstract final class KosovoDistricts {
  static const Map<String, String> names = <String, String>{
    '01': 'Pristina',
    '02': 'Mitrovica',
    '03': 'Peja',
    '04': 'Prizren',
    '05': 'Ferizaj',
    '06': 'Gjilan',
    '07': 'Gjakova',
  };
}

/// Judges a Kosovar plate field by field.
///
/// Formats (the article gives `01 234-AB`; the rest are read off the
/// pictures): private, trailer, agriculture and moped a district code, three
/// digits and two letters; government an agency code (digit and letter), three digits and two digits;
/// police and emergency digits throughout; customs three digits and two
/// letters; Security Force `KSF`, three digits and two digits; the UNMIK-style
/// plate three digits, two letters and three digits; diplomatic a code, two
/// letters and three digits; EULEX four digits. The serial of a plate is not
/// held to the article's 101 floor, which the pictures do not bear out.
/// Reports, never bars a keystroke.
class KosovoValidator extends GatedPlateValidator {
  const KosovoValidator();

  @override
  String get gateGroup => 'series';

  static const String reason = 'The plate does not match its format.';
  static const String reasonDistrict = 'The district code is 01 to 07.';

  static final RegExp _district = RegExp(r'^0[1-7]$');
  static final RegExp _twoDigits = RegExp(r'^\d{2}$');
  static final RegExp _threeDigits = RegExp(r'^\d{3}$');
  static final RegExp _twoLetters = RegExp(r'^[A-Z]{2}$');

  static final Map<String, Map<String, RegExp>> _formats = <String, Map<String, RegExp>>{
    'xk.private': _districtPlate,
    'xk.agriculture': _districtPlate,
    'xk.trailer': _districtPlate,
    'xk.moped': _districtPlate,
    'xk.government': <String, RegExp>{
      'agency': RegExp(r'^\d[A-Z]$'),
      'serial': _threeDigits,
      'series': _twoDigits,
    },
    'xk.police': <String, RegExp>{'serial': _threeDigits, 'series': _twoDigits},
    'xk.emergency': <String, RegExp>{
      'service': _threeDigits,
      'serial': _threeDigits,
      'series': _twoDigits,
    },
    'xk.customs': <String, RegExp>{'serial': _threeDigits, 'series': _twoLetters},
    'xk.military': <String, RegExp>{
      'unit': RegExp(r'^[A-Z]{3}$'),
      'serial': _threeDigits,
      'series': _twoDigits,
    },
    'xk.unmik': <String, RegExp>{
      'serial': _threeDigits,
      'mark': _twoLetters,
      'series': _threeDigits,
    },
    'xk.diplomatic': <String, RegExp>{
      'region': _twoDigits,
      'mark': _twoLetters,
      'series': _threeDigits,
    },
    'xk.eulex': <String, RegExp>{'series': RegExp(r'^\d{4}$')},
  };

  static final Map<String, RegExp> _districtPlate = <String, RegExp>{
    'region': _district,
    'serial': _threeDigits,
    'series': _twoLetters,
  };

  @override
  PlateValidation judge(PlateEntry entry) {
    final Map<String, RegExp>? format = _formats[entry.spec.id];
    if (format == null) return const PlateValidation.valid();
    for (final MapEntry<String, RegExp> f in format.entries) {
      final String value = entry.group(f.key);
      if (!f.value.hasMatch(value)) {
        return PlateValidation.invalid(f.key == 'region' ? reasonDistrict : reason);
      }
    }
    return const PlateValidation.valid();
  }
}
