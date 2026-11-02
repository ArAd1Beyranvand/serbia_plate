/// Serbian licence plates for `plate_core`.
library;

// TODO(py): [D5] one module `plates.countries.serbia`; assets via importlib.resources.
// TODO(ts): [D5] one subpath export `./countries/serbia`; tree-shakable.
// TODO(kt): [D5] package `countries.serbia` in the countries module.
export 'src/serbia_colors.dart';
export 'src/serbia_country.dart';
export 'src/serbia_missions.dart';
export 'src/serbia_plates.dart';
export 'src/serbia_regions.dart';
export 'src/serbia_themes.dart';
export 'src/serbia_validators.dart';
export 'package:plate_alphabet/plate_alphabet.dart' show SerbiaAlphabets;
export 'src/kosovo/kosovo_plate.dart';
