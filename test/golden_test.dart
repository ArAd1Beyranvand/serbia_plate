import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serbia_plate/serbia_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with real bold faces so the ink can be
/// measured against the references (`platekit golden-check`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    for (final String path in const <String>[
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
    ]) {
      final File face = File(path);
      if (!face.existsSync()) continue;
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  /// category id -> (spec, theme, space-separated sample value, one per slot)
  final Map<String, (PlateSpec, PlateTheme, String)> cases =
      <String, (PlateSpec, PlateTheme, String)>{
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
        'oldtimer': (
          SerbiaPlates.oldtimer,
          SerbiaThemes.oldtimer,
          'BG O T 064',
        ),
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
      };

  for (final MapEntry<String, (PlateSpec, PlateTheme, String)> c
      in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, PlateTheme theme, String values) = c.value;
      final PlateController controller = PlateController.fromValues(
        spec,
        values.split(' '),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 680,
                height: 300,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: SerbiaCountry.serbia,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 300)),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/rs_${c.key}.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }

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
