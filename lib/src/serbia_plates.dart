import 'dart:math';

import 'package:flutter/painting.dart' show AssetImage;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'serbia_colors.dart';
import 'serbia_country.dart';
import 'serbia_missions.dart';
import 'serbia_regions.dart';

/// Where the ink sits, in plate units.
///
/// One-line plates (registration, taxi, trailer, police, diplomatic,
/// military) are flattened to the 520×110 mm the article gives and measured
/// off `Obi_ne_tablice_4_broja`, `Belgrade_taxi_licence_plate`,
/// `Serbian_trailer_licence_plate`, `Serbian_police_licence_plate` and
/// `Serbian_diplomatic_licence_plate` by column runs of the ink; the military
/// plate off the `Serbia_government_license_plate` photo.
///
/// One line: ink is 7.5–102 tall (diplomatic 16–94). Ink is ~55% of the box,
/// so a 110 box gives ~60, about 64% of reference; the engine cannot go
/// further inside the canvas. The blue band ends at 48 under the frame, `SRB`
/// in white at y ~78–100. The crest is y 30.5–72 (41.5 tall, aspect 0.751 of
/// `coat_of_arms_shield.png`), with the Cyrillic echo of the area code under
/// it at y 77.5–94.
///
/// Two-row plates (historic, agricultural, moped, motorcycle): the photos are
/// 1.5–1.8 : 1 while the article gives no size, so the canvas is 300×195
/// (1.54, the historic plate's). Rows read off the flats (110 high) are
/// scaled ×1.77 in y and ×0.577 in x. Top row `BG` ink 7.5–56 flat, bottom row
/// 63–102; the band is the top row only, ending at 69.5 flat; the crest is
/// the oldtimer emblem x 388–438, y 14–36 flat. Bottom centres from the
/// historic and agricultural flats (`OT-064`, `99-AAC`): 56, 97.5, dash 130,
/// 162, 203, 245. Top `BG` centres from the sheet at about ±5.
abstract final class _Layout {
  // One line.
  static const double width = 520, height = 110;
  static const double bandEnd = 48;
  static const double top = 0;
  static const double sloLeft = 4, sloTop = 76, sloWidth = 40, sloHeight = 30;
  static const double sloGlyph = 26;
  static const double crestTop = 30.5, crestHeight = 41.5;
  static const double crestWidth = 31.2;
  static const double echoTop = 70.5, echoHeight = 30, echoGlyph = 30;
  static const double echoSpan = 34;
  static const double dotGlyph = 50, sepWidth = 30;

  static const double dipTop = 10, dipHeight = 90;
  static const double stackTop = 12, stackStep = 44, stackHeight = 45;
  static const double stackWidth = 30;

  static const _Group privateRegion = _Group('region', <double>[86.5, 135.8], 48);
  static const _Group privateDigits = _Group('digits', <double>[231.5, 278, 324.5, 371], 46);
  static const _Group privateLetters = _Group('letters', <double>[436, 480.5], 46);

  static const _Group taxiRegion = _Group('region', <double>[73.5, 126], 48);
  static const _Group taxiDigits = _Group('digits', <double>[218, 257, 296, 335, 374], 39);
  static const _Group taxiLetters = _Group('letters', <double>[431, 478], 46);

  static const _Group trailerLetters = _Group('letters', <double>[91, 142], 48);
  static const _Group trailerDigits = _Group('digits', <double>[220, 267, 314], 46);
  static const _Group trailerRegion = _Group('region', <double>[418, 471], 48);

  static const _Group policeLetter = _Group('letter', <double>[87], 46);
  static const _Group policeA = _Group('a', <double>[193, 244, 295], 50);
  static const _Group policeB = _Group('b', <double>[370, 422, 474], 50);

  static const _Group dipCode = _Group('code', <double>[145, 193], 46);
  static const _Group dipLetter = _Group('letter', <double>[262.8], 46);
  static const _Group dipSerial = _Group('serial', <double>[327, 372.5, 418], 46);

  static const _Group militaryLetter = _Group('letter', <double>[168], 60);
  static const _Group militaryDigits = _Group('digits', <double>[298, 354, 410, 466], 56);

  // Two rows.
  static const double rowsWidth = 300, rowsHeight = 195;
  static const double rowsBandEnd = 40, rowsDividerAt = 105;
  static const double rowsDivider = 2;
  static const double topRowTop = 8, topRowHeight = 96;
  static const double bottomRowTop = 108, bottomRowHeight = 82;
  static const double rowsCrestLeft = 224.2, rowsCrestTop = 24.8;
  static const double rowsCrestWidth = 28.8, rowsCrestHeight = 38.9;
  static const double rowsEchoTop = 62.5, rowsEchoSpan = 32;
  static const double rowsSloLeft = 3, rowsSloTop = 60, rowsSloWidth = 36;
  static const double rowsSloHeight = 32, rowsSloGlyph = 24;
  static const double rowsDashGlyph = 70, rowsDashCx = 130;

  static const _Group rowsRegion = _Group('region', <double>[100, 138], 38);
  static const _Group rowsA = _Group('a', <double>[56, 97.5], 40);
  static const _Group rowsB = _Group('b', <double>[162, 203.5, 245], 40);
}

/// A keyed run of slots at the given centres, each [width] wide.
class _Group {
  const _Group(this.key, this.centres, this.width);

  final String key;
  final List<double> centres;
  final double width;
}

const AssetImage _crest = AssetImage(
  // Commons: File:Coat of arms of Serbia small.svg, the shield cut out of it.
  'assets/icons/coat_of_arms_shield.png',
  package: 'serbia_plate',
);

/// The Serbian plates.
///
/// One-line designs share [_oneLine]: [private] `BG [crest] 1234-EC`, [taxi]
/// `BG [crest] 12345·TX`, [trailer] `AB·012 [crest] NS`, [police] `П [crest]
/// 012·345`, [diplomatic] `BG 01·A·234 25` (black on orange, the area code and
/// a two-digit tail stacked at the ends; the diplomatic mission code `20`
/// is refused), [military] `T-2139` with the crest at the left and no band.
/// Two-row designs share [_twoRows]: [oldtimer] `BG / OT-064`, [agricultural]
/// `BG / 99-AAC` on green, [moped] `BG / 12-345` on yellow with no band and
/// [motorcycle] `BG / 12-345`.
///
/// Not implemented: the pre-2011 plate (superseded, not current), the
/// geographical map, the oval `CMD`/`CD` extra plates (no reference), and the
/// three-digit diplomatic country code, since that field is fixed at two
/// digits. The area-code echo in Cyrillic is a mirror of the region field.
///
/// A field is one slot: the area code, the number (three or four digits on
/// [private]) and the series. The diplomatic plate's stacked area code and
/// tail stay two slots each, because their characters are drawn apart.
abstract final class SerbiaPlates {
  static final PlateSpec private = _oneLine(
    id: 'rs.private',
    groups: <_Part>[
      _Part(_Layout.privateRegion, _repeat(SerbiaAlphabets.regionLetters, 2)),
      _Part(_Layout.privateDigits, _repeat(SerbiaAlphabets.digits, 4), minLength: 3),
      _Part(_Layout.privateLetters, _repeat(SerbiaAlphabets.letters, 2)),
    ],
    seps: <(String, double)>[('·', 405)],
    crestCx: 189,
  );

  static final PlateSpec taxi = _oneLine(
    id: 'rs.taxi',
    groups: <_Part>[
      _Part(_Layout.taxiRegion, _repeat(SerbiaAlphabets.regionLetters, 2)),
      _Part(_Layout.taxiDigits, _repeat(SerbiaAlphabets.digits, 5)),
      _Part(_Layout.taxiLetters, <PlateAlphabet>[
        SerbiaAlphabets.taxiFirst,
        SerbiaAlphabets.taxiSecond,
      ]),
    ],
    seps: <(String, double)>[('·', 401)],
    crestCx: 181,
  );

  static final PlateSpec trailer = _oneLine(
    id: 'rs.trailer',
    groups: <_Part>[
      _Part(_Layout.trailerLetters, _repeat(SerbiaAlphabets.letters, 2)),
      _Part(_Layout.trailerDigits, _repeat(SerbiaAlphabets.digits, 3)),
      _Part(_Layout.trailerRegion, _repeat(SerbiaAlphabets.regionLetters, 2)),
    ],
    seps: <(String, double)>[('·', 177)],
    crestCx: 362,
  );

  static final PlateSpec police = _oneLine(
    id: 'rs.police',
    groups: <_Part>[
      _Part(_Layout.policeLetter, <PlateAlphabet>[SerbiaAlphabets.policeLetter]),
      _Part(_Layout.policeA, _repeat(SerbiaAlphabets.digits, 3)),
      _Part(_Layout.policeB, _repeat(SerbiaAlphabets.digits, 3)),
    ],
    seps: <(String, double)>[('·', 332.5)],
    crestCx: 141,
    echo: false,
  );

  static final PlateSpec diplomatic = _oneLine(
    id: 'rs.diplomatic',
    groups: <_Part>[
      _Part(_Layout.dipCode, _repeat(SerbiaAlphabets.digits, 2)),
      _Part(_Layout.dipLetter, <PlateAlphabet>[SerbiaAlphabets.diplomaticLetters]),
      _Part(_Layout.dipSerial, _repeat(SerbiaAlphabets.digits, 3)),
    ],
    seps: <(String, double)>[('·', 228.5), ('·', 296.5)],
    slotTop: _Layout.dipTop,
    slotHeight: _Layout.dipHeight,
    stacks: <_Stack>[
      _Stack('region', 88, SerbiaAlphabets.regionLetters),
      _Stack('tail', 481, SerbiaAlphabets.digits),
    ],
    echo: false,
    restrictions: const <PlateRestriction>[SerbiaMissions.restriction],
  );

  static final PlateSpec military = _oneLine(
    id: 'rs.military',
    groups: <_Part>[
      _Part(_Layout.militaryLetter, <PlateAlphabet>[SerbiaAlphabets.letters]),
      _Part(_Layout.militaryDigits, _repeat(SerbiaAlphabets.digits, 4)),
    ],
    seps: <(String, double)>[('-', 229)],
    band: false,
    echo: false,
    crestBox: const PlateBox(31, 10, 68, 90.5),
  );

  static final PlateSpec oldtimer = _twoRows(
    id: 'rs.oldtimer',
    first: <PlateAlphabet>[SerbiaAlphabets.oldtimerFirst, SerbiaAlphabets.oldtimerSecond],
    second: _repeat(SerbiaAlphabets.digits, 3),
  );

  static final PlateSpec agricultural = _twoRows(
    id: 'rs.agricultural',
    first: _repeat(SerbiaAlphabets.digits, 2),
    second: _repeat(SerbiaAlphabets.letters, 3),
  );

  static final PlateSpec moped = _twoRows(
    id: 'rs.moped',
    first: _repeat(SerbiaAlphabets.digits, 2),
    second: _repeat(SerbiaAlphabets.digits, 3),
    band: false,
  );

  static final PlateSpec motorcycle = _twoRows(
    id: 'rs.motorcycle',
    first: _repeat(SerbiaAlphabets.digits, 2),
    second: _repeat(SerbiaAlphabets.digits, 3),
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    taxi,
    trailer,
    police,
    diplomatic,
    military,
    oldtimer,
    agricultural,
    moped,
    motorcycle,
  ];
}

List<PlateAlphabet> _repeat(PlateAlphabet a, int n) => List<PlateAlphabet>.filled(n, a);

/// A [_Group] with the alphabet of each of its cells. Neighbouring cells on
/// the same alphabet are one field.
class _Part {
  const _Part(this.group, this.alphabets, {this.minLength});

  final _Group group;
  final List<PlateAlphabet> alphabets;

  /// The fewest characters of a variable run; null for a fixed one.
  final int? minLength;
}

/// A two-slot group stacked upright at [cx] (the diplomatic plate's area code
/// and tail), one character above the other.
class _Stack {
  const _Stack(this.key, this.cx, this.alphabet);

  final String key;
  final double cx;
  final PlateAlphabet alphabet;
}

PlateSection _band(double end) => PlateSection.columns(<PlatePart>[
  PlatePart(const PlateSection.fill(PlateFill.panel), end: end),
  const PlatePart(PlateSection.plain),
]);

PlateBox _box(double cx, double width, double top, double height) =>
    PlateBox(cx - width / 2, top, width, height);

PlateSpec _oneLine({
  required String id,
  required List<_Part> groups,
  required List<(String, double)> seps,
  double crestCx = 0,
  PlateBox? crestBox,
  bool band = true,
  bool echo = true,
  double slotTop = _Layout.top,
  double slotHeight = _Layout.height,
  List<_Stack> stacks = const <_Stack>[],
  List<PlateRestriction> restrictions = const <PlateRestriction>[],
}) {
  final List<PlateSlot> slots = <PlateSlot>[];
  final List<PlateTextGroup> textGroups = <PlateTextGroup>[];
  final List<PlateMirror> mirrors = <PlateMirror>[];

  void addGroup(String key, List<PlateSlot> made) {
    final int start = slots.length;
    slots.addAll(made);
    textGroups.add(
      PlateTextGroup(<int>[for (int i = 0; i < made.length; i++) start + i], key: key),
    );
    if (echo && key == 'region') {
      mirrors.add(
        PlateMirror(
          source: start,
          box: _box(crestCx, _Layout.echoSpan, _Layout.echoTop, _Layout.echoHeight),
          glyphHeight: _Layout.echoGlyph,
          alphabet: SerbiaAlphabets.regionCyrillic,
        ),
      );
    }
  }

  // The stacked area code sits first, the tail last, as on the plate.
  for (final _Stack s in stacks.where((s) => s.key == 'region')) {
    addGroup(s.key, _stackSlots(s));
  }
  for (final _Part p in groups) {
    addGroup(
      p.group.key,
      _fields(
        p.alphabets,
        p.group.centres,
        p.group.width,
        slotTop,
        slotHeight,
        minLength: p.minLength,
      ),
    );
  }
  for (final _Stack s in stacks.where((s) => s.key != 'region')) {
    addGroup(s.key, _stackSlots(s));
  }

  final PlateBox crest =
      crestBox ?? _box(crestCx, _Layout.crestWidth, _Layout.crestTop, _Layout.crestHeight);

  return PlateSpec(
    id: id,
    country: SerbiaCountry.serbia,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0)),
    noPanel: true,
    background: band ? _band(_Layout.bandEnd) : PlateSection.plain,
    slots: slots,
    mirrors: mirrors,
    labels: <PlateLabel>[
      if (band)
        const PlateLabel(
          text: 'SRB',
          box: PlateBox(_Layout.sloLeft, _Layout.sloTop, _Layout.sloWidth, _Layout.sloHeight),
          glyphHeight: _Layout.sloGlyph,
          color: SerbiaColors.white,
        ),
      for (final (String text, double cx) in seps)
        PlateLabel(
          text: text,
          box: _box(cx, _Layout.sepWidth, _Layout.top, _Layout.height),
          glyphHeight: text == '·' ? _Layout.dotGlyph : _Layout.height,
        ),
    ],
    decals: <PlateDecal>[
      if (crestCx > 0 || crestBox != null) PlateDecal(image: _crest, box: crest),
    ],
    textGroups: textGroups,
    resolveRegion: SerbiaRegions.captionOf,
    restrictions: restrictions,
  );
}

/// One slot per run of neighbouring cells on the same alphabet; the box
/// spans the run at the cells' pitch and a fixed run is spaced to it.
List<PlateSlot> _fields(
  List<PlateAlphabet> alphabets,
  List<double> centres,
  double width,
  double top,
  double height, {
  int? minLength,
}) {
  final double pitch = centres.length > 1
      ? (centres.last - centres.first) / (centres.length - 1)
      : 0;
  final List<PlateSlot> slots = <PlateSlot>[];
  for (int i = 0; i < alphabets.length;) {
    int j = i + 1;
    while (j < alphabets.length && alphabets[j] == alphabets[i]) {
      j++;
    }
    final int count = j - i;
    slots.add(
      count == 1
          ? PlateSlot(alphabet: alphabets[i], box: _box(centres[i], width, top, height))
          : PlateSlot(
              alphabet: alphabets[i],
              box: PlateBox(centres[i] - pitch / 2, top, count * pitch, height),
              length: count,
              minLength: minLength,
              spacing: minLength == null ? max(0, pitch - 0.6 * 0.72 * height) : 0,
            ),
    );
    i = j;
  }
  return slots;
}

List<PlateSlot> _stackSlots(_Stack s) => <PlateSlot>[
  for (int i = 0; i < 2; i++)
    PlateSlot(
      alphabet: s.alphabet,
      box: _box(
        s.cx,
        _Layout.stackWidth,
        _Layout.stackTop + i * _Layout.stackStep,
        _Layout.stackHeight,
      ),
    ),
];

PlateSpec _twoRows({
  required String id,
  required List<PlateAlphabet> first,
  required List<PlateAlphabet> second,
  bool band = true,
}) {
  List<PlateSlot> bottom(List<PlateAlphabet> alphabets, _Group g) =>
      _fields(alphabets, g.centres, g.width, _Layout.bottomRowTop, _Layout.bottomRowHeight);
  final List<PlateSlot> aFields = bottom(first, _Layout.rowsA);
  final List<PlateSlot> bFields = bottom(second, _Layout.rowsB);
  final int aSlots = aFields.length, bSlots = bFields.length;
  final List<PlateSlot> slots = <PlateSlot>[
    ..._fields(
      _repeat(SerbiaAlphabets.regionLetters, 2),
      _Layout.rowsRegion.centres,
      _Layout.rowsRegion.width,
      _Layout.topRowTop,
      _Layout.topRowHeight,
    ),
    ...aFields,
    ...bFields,
  ];
  const double crestCx = _Layout.rowsCrestLeft + _Layout.rowsCrestWidth / 2;

  return PlateSpec(
    id: id,
    country: SerbiaCountry.serbia,
    canvasWidth: _Layout.rowsWidth,
    canvasHeight: _Layout.rowsHeight,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0)),
    noPanel: true,
    background: PlateSection.rows(<PlatePart>[
      PlatePart(
        band ? _band(_Layout.rowsBandEnd) : PlateSection.plain,
        end: _Layout.rowsDividerAt,
        divider: _Layout.rowsDivider,
      ),
      const PlatePart(PlateSection.plain),
    ]),
    slots: slots,
    mirrors: <PlateMirror>[
      PlateMirror(
        source: 0,
        box: _box(crestCx, _Layout.rowsEchoSpan, _Layout.rowsEchoTop, _Layout.echoHeight),
        glyphHeight: _Layout.echoGlyph,
        alphabet: SerbiaAlphabets.regionCyrillic,
      ),
    ],
    labels: <PlateLabel>[
      if (band)
        const PlateLabel(
          text: 'SRB',
          box: PlateBox(
            _Layout.rowsSloLeft,
            _Layout.rowsSloTop,
            _Layout.rowsSloWidth,
            _Layout.rowsSloHeight,
          ),
          glyphHeight: _Layout.rowsSloGlyph,
          color: SerbiaColors.white,
        ),
      PlateLabel(
        text: '-',
        box: _box(
          _Layout.rowsDashCx,
          _Layout.sepWidth,
          _Layout.bottomRowTop,
          _Layout.bottomRowHeight,
        ),
        glyphHeight: _Layout.rowsDashGlyph,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        image: _crest,
        box: PlateBox(
          _Layout.rowsCrestLeft,
          _Layout.rowsCrestTop,
          _Layout.rowsCrestWidth,
          _Layout.rowsCrestHeight,
        ),
      ),
    ],
    resolveRegion: SerbiaRegions.captionOf,
    textGroups: <PlateTextGroup>[
      const PlateTextGroup(<int>[0], key: 'region'),
      PlateTextGroup(<int>[for (int i = 0; i < aSlots; i++) 1 + i], key: 'a'),
      PlateTextGroup(<int>[for (int i = 0; i < bSlots; i++) 1 + aSlots + i], key: 'b'),
    ],
  );
}
