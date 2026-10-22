import 'dart:math';

import 'package:plate_core/plate_core.dart';

/// Random values for fixtures and demos, one string per slot. A `region` field
/// is a district code 01–07; a `mark` field is `KS`; `unit` is `KSF`.
abstract final class KosovoSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    final List<String?> values = <String?>[
      for (final PlateSlot slot in spec.slots)
        List<String>.generate(
          slot.length,
          (_) => slot.alphabet.characters[rnd.nextInt(slot.alphabet.characters.length)],
        ).join(),
    ];
    void fill(String key, String text) {
      if (spec.indicesOfGroup(key).singleOrNull case final int i) {
        values[i] = text;
      }
    }

    fill('region', '0${1 + rnd.nextInt(7)}');
    fill('mark', 'KS');
    fill('unit', 'KSF');
    return values;
  }
}
