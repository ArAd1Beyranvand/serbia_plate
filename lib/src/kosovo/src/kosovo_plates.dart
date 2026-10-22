import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'kosovo_colors.dart';
import 'kosovo_country.dart';

/// Where the ink sits, in plate units. The single-line references are
/// flattened to the 520×110 mm the article gives (4 px per unit); every
/// number is an ink-run measurement of those flats (field centres from the
/// first cell's centre, or the span's centre where the first glyph is a
/// narrow `1`).
///
/// Single-line plates (centres; pitch):
/// - private `01 999-AD`: 01 at 81/50, 999 at 241/50, AD at 428/50.3, dash
///   384, crest x 172.5–205 y 37–72, strip blue to x 47.3. Ink 16–94 tall
///   (78 mm), band RKS gold at x 8.6–41, y 74–91.
/// - police `POLICE 999-01`: POLICE ink x 52–172, 32 tall; 999 at 240/50.6,
///   dash 386, 01 at 431/50.
/// - emergency `112 001-01`: 112 at 85/41, 001 at 268/49.9, dash 395, 01 at
///   430/46, crest x 210–240.
/// - customs `CUSTOMS 001-DG`: CUSTOMS ink x 64–207, 29 tall; 001 at 269/48.5,
///   dash 394.5, DG at 429/46.
/// - military `KSF-000-01`: KSF at 87/41.4, 000 at 238/42.4, 01 at 396.5/42.5,
///   dashes 203 and 359.5, crest x 17–57. The Security Force's own emblem at
///   the right (x 460–505) is not on the page and is not drawn.
/// - UNMIK-style `648-KS-678`: 648 at 32/52.5, KS at 232/56, 678 at 385/52,
///   dashes 184 and 336.5. Ink 8–102 tall.
///
/// **Under-height ink, accepted.** The references print ink 78 tall; a box
/// that tall would need ~140 on a 110 plate (`glyphStyle` is 0.72 of the box
/// and a bold digit ~0.73 of that), so every box is the full 110 and the ink
/// lands near 60, ~77% of reference. `plate_core` is unchanged.
///
/// Stacked plates, drawn at the aspect of the original photographs (the flats
/// stretch them to 4.7:1), so flat x is scaled and flat y scaled up:
/// - agriculture, 320×200 (flat 520×110, ×0.615, ×1.818): `01` ink x
///   140–215, y 18–91; `101-VA` 54–302, y 111–185; band to x 46.7, y 98.
/// - trailer, 340×192 (×0.654, ×1.745): `01` x 143–223, y 7–89; `427-TA`
///   x 48–318, y 100–181; band to x 49, y 88.5.
/// - moped, 200×294 (×0.385, ×2.67; the photo is 0.68:1): `04` x 56–145,
///   `138` x 40–170, `-RA` x 42–170; band to x 45, y 92.
///
/// Estimated, not measured: the diplomatic (`16-CD-009`) and EULEX (`5250`)
/// plates, whose photographs are 250×58 px; their cells are an even pitch
/// over the ink span. The year sticker on the CD plate and the `EU` text on
/// EULEX are not drawn.
abstract final class _Layout {
  static const double width = 520, height = 110;
  static const double box = 110;

  static const double bandEnd = 47.3;
  static const PlateBox rks = PlateBox(5, 70, 40, 24);
  static const double rksGlyph = 19;
  static const PlateBox crest = PlateBox(172.5, 37, 32.5, 35);
  static const double dashWidth = 30;

  /// Lead captions are as wide as the reference ink in DejaVu Bold, not as
  /// tall: a label does not shrink to fit.
  static const double captionGlyph = 35;
}

const PlateAlphabet _digits = KosovoAlphabets.digits;
const PlateAlphabet _letters = KosovoAlphabets.letters;
const PlateAlphabet _mixed = KosovoAlphabets.mixed;

/// One field: [count] cells of [pitch] from the centre [firstCentre] of the
/// first.
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.firstCentre,
    this.pitch,
    this.count, {
    this.top = 0,
    this.height = _Layout.box,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double firstCentre, pitch;
  final int count;
  final double top, height;
}

/// A printed hyphen centred on [cx], in the row that starts at [top].
class _Dash {
  const _Dash(this.cx, {this.top = 0, this.height = _Layout.box});

  final double cx, top, height;
}

/// Kosovo's plates, one builder over fields, dashes, a strip and a crest.
///
/// - [private] `01 999-AD`: district, serial, series; the arms between the
///   district and the serial. [government] is the same body with an agency
///   code (`3Z`, digit and letter) and a two-digit series (`107-07`).
/// - [police], [emergency], [customs] and [military] are the same line with a
///   caption or service number in place of the district.
/// - [unmik] `648-KS-678` has no strip and no arms.
/// - [agriculture], [trailer] and [moped] stack the district, serial and
///   series on two or three rows with the strip at the top left.
/// - [diplomatic] and [eulex] are estimated from small photographs.
///
/// Not implemented: the Kosovo Protection Corps plate (defunct), the Irish
/// KFOR contingent's plate (a foreign plate), and the 1998–99 Yugoslav
/// format, none of which Kosovo issues.
abstract final class KosovoPlates {
  static final PlateSpec private = _spec(
    id: 'xk.private',
    strip: true,
    crest: _Layout.crest,
    fields: const <_Field>[
      _Field('region', _digits, 81, 50, 2),
      _Field('serial', _digits, 241, 50, 3),
      _Field('series', _letters, 428, 50.3, 2),
    ],
    dashes: const <_Dash>[_Dash(384)],
  );

  /// `3Z 107-07`: the agency code mixes a digit and a letter.
  static final PlateSpec government = _spec(
    id: 'xk.government',
    strip: true,
    crest: _Layout.crest,
    fields: const <_Field>[
      _Field('agency', _mixed, 81, 50, 2),
      _Field('serial', _digits, 241, 50, 3),
      _Field('series', _digits, 428, 50.3, 2),
    ],
    dashes: const <_Dash>[_Dash(384)],
  );

  static final PlateSpec police = _spec(
    id: 'xk.police',
    strip: true,
    crest: _Layout.crest,
    fields: const <_Field>[
      _Field('serial', _digits, 240, 50.6, 3),
      _Field('series', _digits, 431, 50, 2),
    ],
    dashes: const <_Dash>[_Dash(386)],
    labels: const <PlateLabel>[
      PlateLabel(text: 'POLICE', box: PlateBox(52, 28, 121, 54), glyphHeight: _Layout.captionGlyph),
    ],
  );

  static final PlateSpec emergency = _spec(
    id: 'xk.emergency',
    strip: true,
    crest: const PlateBox(210, 41, 30, 31),
    fields: const <_Field>[
      _Field('service', _digits, 85, 41, 3),
      _Field('serial', _digits, 268, 49.9, 3),
      _Field('series', _digits, 430, 46, 2),
    ],
    dashes: const <_Dash>[_Dash(395)],
  );

  /// The blue field is the strip, so only the gold `RKS` marks it.
  static final PlateSpec customs = _spec(
    id: 'xk.customs',
    crest: const PlateBox(210, 41, 30, 32),
    fields: const <_Field>[
      _Field('serial', _digits, 269, 48.5, 3),
      _Field('series', _letters, 429, 46, 2),
    ],
    dashes: const <_Dash>[_Dash(394.5)],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'CUSTOMS',
        box: PlateBox(60, 36, 150, 40),
        glyphHeight: _Layout.captionGlyph,
      ),
      _rksCaption,
    ],
  );

  static final PlateSpec military = _spec(
    id: 'xk.military',
    crest: const PlateBox(17, 34, 40, 44),
    fields: const <_Field>[
      _Field('unit', _letters, 87, 41.4, 3),
      _Field('serial', _digits, 238, 42.4, 3),
      _Field('series', _digits, 396.5, 42.5, 2),
    ],
    dashes: const <_Dash>[_Dash(203), _Dash(359.5)],
  );

  /// `648-KS-678`, white or blue (the customs-guard livery is a theme).
  static final PlateSpec unmik = _spec(
    id: 'xk.unmik',
    fields: const <_Field>[
      _Field('serial', _digits, 32, 52.5, 3),
      _Field('mark', _letters, 232, 56, 2),
      _Field('series', _digits, 385, 52, 3),
    ],
    dashes: const <_Dash>[_Dash(184), _Dash(336.5)],
  );

  /// `16-CD-009`. Estimated: an even pitch over the photograph's ink span
  /// x 69–426.
  static final PlateSpec diplomatic = _spec(
    id: 'xk.diplomatic',
    fields: const <_Field>[
      _Field('region', _digits, 89, 39.7, 2, top: 7, height: 96),
      _Field('mark', _letters, 208, 39.7, 2, top: 7, height: 96),
      _Field('series', _digits, 327, 39.7, 3, top: 7, height: 96),
    ],
    dashes: const <_Dash>[_Dash(168, top: 7, height: 96), _Dash(287, top: 7, height: 96)],
    labels: const <PlateLabel>[
      PlateLabel(text: 'RKS', box: PlateBox(14, 15, 36, 80), glyphHeight: 24, rotated: true),
    ],
  );

  /// `5250` between the EU ring and `LEX`. Estimated from a 250×55 photo.
  static final PlateSpec eulex = _spec(
    id: 'xk.eulex',
    fields: const <_Field>[_Field('series', _digits, 188, 53, 4)],
    decals: const <PlateDecal>[
      PlateDecal(drawing: EuropeanStars.band, box: PlateBox(12, 9, 60, 92)),
    ],
    labels: const <PlateLabel>[
      PlateLabel(text: 'LEX', box: PlateBox(440, 30, 64, 50), glyphHeight: 30),
    ],
  );

  static const PlateLabel _rksCaption = PlateLabel(
    text: 'RKS',
    box: _Layout.rks,
    glyphHeight: _Layout.rksGlyph,
    color: KosovoColors.rksGold,
  );

  // Stacked plates.
  static const double _stackGlyph = 96;

  static final PlateSpec agriculture = _spec(
    id: 'xk.agriculture',
    width: 320,
    height: 200,
    strip: true,
    stripEnd: 46.7,
    stripBottom: 98,
    stripCaption: const PlateBox(7, 60, 38, 30),
    crest: const PlateBox(235, 38, 28, 31),
    fields: const <_Field>[
      _Field('region', _digits, 158, 45, 2, top: 4, height: 100),
      _Field('serial', _digits, 112.5, 46, 3, top: 98, height: 100),
      _Field('series', _letters, 239, 45, 2, top: 98, height: 100),
    ],
    dashes: const <_Dash>[_Dash(197.7, top: 98, height: 100)],
  );

  static final PlateSpec trailer = _spec(
    id: 'xk.trailer',
    width: 340,
    height: 192,
    strip: true,
    stripEnd: 49,
    stripBottom: 88.5,
    stripCaption: const PlateBox(6, 50, 40, 30),
    crest: const PlateBox(256, 36, 26, 29),
    fields: const <_Field>[
      _Field('region', _digits, 159, 48, 2, top: 0, height: _stackGlyph),
      _Field('serial', _digits, 68.5, 49.5, 3, top: 92.5, height: _stackGlyph),
      _Field('series', _letters, 251, 47.5, 2, top: 92.5, height: _stackGlyph),
    ],
    dashes: const <_Dash>[_Dash(208, top: 92.5, height: _stackGlyph)],
  );

  static final PlateSpec moped = _spec(
    id: 'xk.moped',
    width: 200,
    height: 294,
    strip: true,
    stripEnd: 45,
    stripBottom: 92,
    stripCaption: const PlateBox(3, 58, 40, 26),
    crest: const PlateBox(151, 40, 26, 29),
    fields: const <_Field>[
      _Field('region', _digits, 75, 50, 2, top: 7, height: _stackGlyph),
      _Field('serial', _digits, 57, 48, 3, top: 98, height: _stackGlyph),
      _Field('series', _letters, 101, 46, 2, top: 190, height: _stackGlyph),
    ],
    dashes: const <_Dash>[_Dash(50, top: 190, height: _stackGlyph)],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    government,
    police,
    emergency,
    customs,
    military,
    unmik,
    diplomatic,
    eulex,
    agriculture,
    trailer,
    moped,
  ];

  /// The field as one slot: its box spans the cells at their pitch.
  static PlateSlot _slot(_Field f) => PlateSlot(
    alphabet: f.alphabet,
    box: PlateBox(f.firstCentre - f.pitch / 2, f.top, f.count * f.pitch, f.height),
    length: f.count,
    spacing: max(0, f.pitch - 0.6 * 0.72 * f.height),
  );

  static PlateSpec _spec({
    required String id,
    required List<_Field> fields,
    double width = _Layout.width,
    double height = _Layout.height,
    List<_Dash> dashes = const <_Dash>[],
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateDecal> decals = const <PlateDecal>[],
    PlateBox? crest,
    bool strip = false,
    double stripEnd = _Layout.bandEnd,
    double? stripBottom,
    PlateBox stripCaption = _Layout.rks,
  }) {
    const PlateSection blue = PlateSection.fill(PlateFill.color(KosovoColors.rksBlue));
    return PlateSpec(
      id: id,
      country: KosovoCountry.kosovo,
      canvasWidth: width,
      canvasHeight: height,
      noPanel: true,
      panel: PlatePanel(box: PlateBox(0, 0, 0, height)),
      background: !strip
          ? PlateSection.plain
          : PlateSection.columns(<PlatePart>[
              PlatePart(
                stripBottom == null
                    ? blue
                    : PlateSection.rows(<PlatePart>[
                        PlatePart(blue, end: stripBottom),
                        const PlatePart(PlateSection.plain),
                      ]),
                end: stripEnd,
              ),
              const PlatePart(PlateSection.plain),
            ]),
      slots: <PlateSlot>[for (final _Field f in fields) _slot(f)],
      labels: <PlateLabel>[
        if (strip)
          PlateLabel(
            text: 'RKS',
            box: stripCaption,
            glyphHeight: _Layout.rksGlyph,
            color: KosovoColors.rksGold,
          ),
        ...labels,
        for (final _Dash d in dashes)
          PlateLabel(
            text: '-',
            box: PlateBox(d.cx - _Layout.dashWidth / 2, d.top, _Layout.dashWidth, d.height),
            glyphHeight: d.height,
          ),
      ],
      decals: <PlateDecal>[
        // Coat of arms of Kosovo: assets/icons/coat_of_arms_of_kosovo.svg
        // (Commons `Coat of arms of Republic of Kosovo.svg`), rasterised to
        // the .png. A crest, so a decal rather than painted.
        if (crest != null)
          PlateDecal(
            image: const AssetImage(
              'assets/kosovo/icons/coat_of_arms_of_kosovo.png',
              package: 'serbia_plate',
            ),
            box: crest,
          ),
        ...decals,
      ],
      textGroups: <PlateTextGroup>[
        for (int i = 0; i < fields.length; i++) PlateTextGroup(<int>[i], key: fields[i].key),
      ],
    );
  }
}
