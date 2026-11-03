FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Serbia to view examples:

https://platexample.ir/#/discover/serbia:typescript

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

### Install (TypeScript)

Copy `typescript/src/countries/serbia/` into `plate_core/typescript/src/countries/`.

Then run the tests from `plate_core/typescript/`: `npm test`.

### Use

```ts
import country from './countries/serbia';

const spec = country.specs.get('xk.private');
console.log(country.package);
```

## Specs

The specs are the same in every language (they come from shared data).

- `xk.private`
- `xk.government`
- `xk.police`
- `xk.emergency`
- `xk.customs`
- `xk.military`
- `xk.unmik`
- `xk.diplomatic`
- `xk.eulex`
- `xk.agriculture`
- `xk.trailer`
- `xk.moped`
- `rs.private`
- `rs.taxi`
- `rs.trailer`
- `rs.police`
- `rs.diplomatic`
- `rs.military`
- `rs.oldtimer`
- `rs.agricultural`
- `rs.moped`
- `rs.motorcycle`

## Themes

- `KosovoThemes.private`
- `KosovoThemes.plain`
- `KosovoThemes.police`
- `KosovoThemes.emergency`
- `KosovoThemes.customs`
- `KosovoThemes.unmikCustoms`
- `KosovoThemes.military`
- `KosovoThemes.agriculture`
- `KosovoThemes.trailer`
- `KosovoThemes.diplomatic`
- `KosovoThemes.eulex`
- `SerbiaThemes.private`
- `SerbiaThemes.police`
- `SerbiaThemes.diplomatic`
- `SerbiaThemes.military`
- `SerbiaThemes.agricultural`
- `SerbiaThemes.moped`

## Change it

- Specs: `country.specs`, by id.
- Themes: `country.themes`.
- Validators: `country.validators` (`KosovoValidator`, `SerbiaValidator`).

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/serbia_plate/blob/main/LICENSE).
