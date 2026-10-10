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

  /// category id -> (spec, theme, space-separated sample value)
  final Map<String, (PlateSpec, PlateTheme, String)>
  cases = <String, (PlateSpec, PlateTheme, String)>{
    'private': (SerbiaPlates.private, SerbiaThemes.private, 'B G 1 2 3 4 E C'),
    'taxi': (SerbiaPlates.taxi, SerbiaThemes.taxi, 'B G 1 2 3 4 5 T X'),
    'trailer': (SerbiaPlates.trailer, SerbiaThemes.trailer, 'A B 0 1 2 N S'),
    'police': (SerbiaPlates.police, SerbiaThemes.police, 'П 0 1 2 3 4 5'),
    'diplomatic': (
      SerbiaPlates.diplomatic,
      SerbiaThemes.diplomatic,
      'B G 0 1 A 2 3 4 2 5',
    ),
    'military': (SerbiaPlates.military, SerbiaThemes.military, 'T 2 1 3 9'),
    'oldtimer': (SerbiaPlates.oldtimer, SerbiaThemes.oldtimer, 'B G O T 0 6 4'),
    'agricultural': (
      SerbiaPlates.agricultural,
      SerbiaThemes.agricultural,
      'B G 9 9 A A C',
    ),
    'moped': (SerbiaPlates.moped, SerbiaThemes.moped, 'B G 0 1 2 6 9'),
    'motorcycle': (
      SerbiaPlates.motorcycle,
      SerbiaThemes.motorcycle,
      'B G 0 1 2 6 9',
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
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/rs_${c.key}.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
