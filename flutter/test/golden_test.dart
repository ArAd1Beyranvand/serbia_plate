import 'package:flutter_test/flutter_test.dart';
import 'package:plate_core/plate_core.dart';
import 'package:plate_core/testing.dart';
import 'package:serbia_plate/serbia_plate.dart';

void main() {
  plateGoldens('rs', SerbiaCountry.serbia, <String, PlateGoldenCase>{
    'private': (SerbiaPlates.private, SerbiaThemes.private, 'BG 1234 EC'),
    'private_three_digits': (
      SerbiaPlates.private,
      SerbiaThemes.private,
      'NS 123 AB',
    ),
    'taxi': (SerbiaPlates.taxi, SerbiaThemes.taxi, 'BG 12345 T X'),
    'trailer': (SerbiaPlates.trailer, SerbiaThemes.trailer, 'AB 012 NS'),
    'police': (SerbiaPlates.police, SerbiaThemes.police, 'П 012 345'),
    'diplomatic': (
      SerbiaPlates.diplomatic,
      SerbiaThemes.diplomatic,
      'B G 01 A 234 2 5',
    ),
    'military': (SerbiaPlates.military, SerbiaThemes.military, 'T 2139'),
    'oldtimer': (SerbiaPlates.oldtimer, SerbiaThemes.oldtimer, 'BG O T 064'),
    'agricultural': (
      SerbiaPlates.agricultural,
      SerbiaThemes.agricultural,
      'BG 99 AAC',
    ),
    'moped': (SerbiaPlates.moped, SerbiaThemes.moped, 'BG 01 269'),
    'motorcycle': (
      SerbiaPlates.motorcycle,
      SerbiaThemes.motorcycle,
      'BG 01 269',
    ),
  }, decodeDelay: const Duration(milliseconds: 300));

  test('the number is one field of three or four digits', () {
    final PlateSpec spec = SerbiaPlates.private;
    expect(spec.slots.map((PlateSlot s) => s.length), <int>[2, 4, 2]);
    expect(spec.slots.map((PlateSlot s) => s.minLength), <int>[2, 3, 2]);
    PlateController c = PlateController.fromValues(spec, ['BG', '123', 'AB']);
    expect(c.isCompleted, isTrue);
    c.dispose();
    c = PlateController.fromValues(spec, ['BG', '12', 'AB']);
    expect(c.isCompleted, isFalse);
    c.dispose();
  });
}
