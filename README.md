FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Serbia to view examples:

https://platexample.ir/#/discover/serbia

# serbia_plate

Serbian licence plates for `plate_core`.

## Install

```yaml
dependencies:
  plate_core: ^0.12.0
  serbia_plate: ^0.1.0
```

## Use

```dart
import 'package:plate_core/plate_core.dart';
import 'package:serbia_plate/serbia_plate.dart';

PlateCanvas(
  spec: KosovoPlates.private,
  theme: KosovoThemes.private,
  validator: const KosovoValidator(),
  autoValidate: true,
  onChooseCharacter: noCharacterChooser,
);
```

## Contains

- `KosovoCountry` — country panel: `kosovo`.
- `SerbiaCountry` — country panel: `serbia`.
- `KosovoPlates` — 12 plate specs: `private`, `government`, `police`, `emergency`, `customs`, `military`, `unmik`, `diplomatic`, `eulex`, `agriculture`, `trailer`, `moped`.
- `SerbiaPlates` — 10 plate specs: `private`, `taxi`, `trailer`, `police`, `diplomatic`, `military`, `oldtimer`, `agricultural`, `moped`, `motorcycle`.
- `KosovoThemes` — 11 themes: `private`, `plain`, `police`, `emergency`, `customs`, `unmikCustoms`, `military`, `agriculture`, `trailer`, `diplomatic` and 1 more.
- `SerbiaThemes` — 10 themes: `private`, `taxi`, `trailer`, `police`, `diplomatic`, `military`, `oldtimer`, `agricultural`, `moped`, `motorcycle`.
- `KosovoValidator` — advisory validator; flags the frame, never blocks a keystroke.
- `SerbiaValidator` — advisory validator; flags the frame, never blocks a keystroke.
- `KosovoSerialGenerator` — random plate generator.
- `KosovoDistricts` — code table.
- `SerbiaMissions` — code table.
- `SerbiaRegions` — code table.
- 2 bundled assets (``, ``).

## Plates

Kosovo's plates, one builder over fields, dashes, a strip and a crest.

- `private` `01 999-AD`: district, serial, series; the arms between the
  district and the serial. `government` is the same body with an agency
  code (`3Z`, digit and letter) and a two-digit series (`107-07`).
- `police`, `emergency`, `customs` and `military` are the same line with a
  caption or service number in place of the district.
- `unmik` `648-KS-678` has no strip and no arms.
- `agriculture`, `trailer` and `moped` stack the district, serial and
  series on two or three rows with the strip at the top left.
- `diplomatic` and `eulex` are estimated from small photographs.

Not implemented: the Kosovo Protection Corps plate (defunct), the Irish
KFOR contingent's plate (a foreign plate), and the 1998–99 Yugoslav
format, none of which Kosovo issues.

The Serbian plates.

Not implemented: the pre-2011 plate (superseded, not current), the
geographical map, the oval `CMD`/`CD` extra plates (no reference), and the
three-digit diplomatic country code, since that field is fixed at two
digits. The area-code echo in Cyrillic is a mirror of the region field.

A field is one slot: the area code, the number (three or four digits on
`private`) and the series. The diplomatic plate's stacked area code and
tail stay two slots each, because their characters are drawn apart.

## Part of plate

Painted by [`plate_core`](https://pub.dev/packages/plate_core); alphabets shared through [`plate_alphabet`](https://pub.dev/packages/plate_alphabet); optional character picker in [`plate_keypad`](https://pub.dev/packages/plate_keypad).

