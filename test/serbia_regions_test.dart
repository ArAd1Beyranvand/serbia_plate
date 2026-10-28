import 'package:flutter_test/flutter_test.dart';
import 'package:plate_core/plate_core.dart';
import 'package:serbia_plate/serbia_plate.dart';

void main() {
  test('a full code names the area', () {
    expect(SerbiaRegions.lookup('NS'), 'Novi Sad');
    expect(SerbiaRegions.lookup('ČA'), 'Čačak');
  });

  test('a lone letter shared by several areas, or none, names nothing', () {
    for (final String code in <String>['', 'N', 'B', 'XX', 'QQ']) {
      expect(SerbiaRegions.lookup(code), isNull, reason: code);
    }
  });

  test('the private and trailer plates follow the code typed and deleted', () {
    for (final PlateSpec spec in <PlateSpec>[
      SerbiaPlates.private,
      SerbiaPlates.trailer,
    ]) {
      final PlateController c = PlateController(spec: spec);
      expect(c.regionCaption, isNull, reason: spec.id);
      c.setGroup('region', 'N');
      expect(c.regionCaption, isNull, reason: spec.id);
      c.setGroup('region', 'NS');
      expect(c.regionCaption, 'Novi Sad', reason: spec.id);
      c.setGroup('region', 'N');
      expect(c.regionCaption, isNull, reason: spec.id);
    }
  });

  test('a plate without an area code has no caption', () {
    final PlateController c = PlateController(spec: SerbiaPlates.military);
    expect(c.regionCaption, isNull);
  });
}
