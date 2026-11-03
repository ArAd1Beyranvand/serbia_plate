FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Serbia to view examples:

https://platexample.ir/#/discover/serbia:flutter

# serbia_plate

Serbia's licence plates for plate_core: ten categories on a white, blue, orange-on-black, green or yellow field, one theme each, the Latin, and more.

## Languages

| Language | Folder | Example |
| --- | --- | --- |
| Flutter / Dart | [`flutter/`](https://github.com/ArAd1Beyranvand/serbia_plate/tree/main/flutter) | [platexample](https://platexample.ir/#/discover/serbia:flutter) |
| Kotlin | [`kotlin/`](https://github.com/ArAd1Beyranvand/serbia_plate/tree/main/kotlin) | [platexample](https://platexample.ir/#/discover/serbia:kotlin) |
| Python | [`python/`](https://github.com/ArAd1Beyranvand/serbia_plate/tree/main/python) | [platexample](https://platexample.ir/#/discover/serbia:python) |
| TypeScript | [`typescript/`](https://github.com/ArAd1Beyranvand/serbia_plate/tree/main/typescript) | [platexample](https://platexample.ir/#/discover/serbia:typescript) |

## Quick start

### Install

```yaml
dependencies:
  plate_core: ^0.12.0
  serbia_plate: ^0.1.0
```

### Use

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

## Specs

Each spec is one plate layout.

- `SerbiaPlates.private` — id `rs.private`
- `SerbiaPlates.taxi` — id `rs.taxi`
- `SerbiaPlates.trailer` — id `rs.trailer`
- `SerbiaPlates.police` — id `rs.police`
- `SerbiaPlates.diplomatic` — id `rs.diplomatic`
- `SerbiaPlates.military` — id `rs.military`
- `SerbiaPlates.oldtimer` — id `rs.oldtimer`
- `SerbiaPlates.agricultural` — id `rs.agricultural`
- `SerbiaPlates.moped` — id `rs.moped`
- `SerbiaPlates.motorcycle` — id `rs.motorcycle`

## Themes

- `SerbiaThemes.private`
- `SerbiaThemes.taxi`
- `SerbiaThemes.trailer`
- `SerbiaThemes.police`
- `SerbiaThemes.diplomatic`
- `SerbiaThemes.military`
- `SerbiaThemes.oldtimer`
- `SerbiaThemes.agricultural`
- `SerbiaThemes.moped`
- `SerbiaThemes.motorcycle`

## Change it

`PlateCanvas` takes `spec:` (an entry of `SerbiaPlates`) and `theme:` (an entry of `SerbiaThemes`). Set `validator:` to `SerbiaValidator()` and `autoValidate: true` to show validation hints.

## Also included

- `SerbiaCountry` — the country panel.
- `SerbiaValidator` — the plate validator.
- `SerbiaMissions` — code table.
- `SerbiaRegions` — code table.

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

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/serbia_plate/blob/main/LICENSE).
