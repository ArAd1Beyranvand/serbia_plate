import 'package:plate_core/plate_core.dart';

/// Names the registration area from its two-letter code.
///
/// Source: the "Regional codes" table in
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Serbia
abstract final class SerbiaRegions {
  static const Map<String, String> _areas = <String, String>{
    'AL': 'Aleksinac',
    'AR': 'Aranđelovac',
    'AC': 'Aleksandrovac',
    'BB': 'Bajina Bašta',
    'BG': 'Belgrade',
    'BO': 'Bor',
    'BP': 'Bačka Palanka',
    'BT': 'Bačka Topola',
    'BĆ': 'Bogatić',
    'BU': 'Bujanovac',
    'BČ': 'Bečej',
    'VA': 'Valjevo',
    'VB': 'Vrnjačka Banja',
    'VL': 'Vlasotince',
    'VP': 'Velika Plana',
    'VR': 'Vranje',
    'VS': 'Vrbas',
    'VŠ': 'Vršac',
    'GM': 'Gornji Milanovac',
    'DE': 'Despotovac',
    'ZA': 'Zaječar',
    'ZR': 'Zrenjanin',
    'IN': 'Inđija',
    'IC': 'Ivanjica',
    'JA': 'Jagodina',
    'KA': 'Kanjiža',
    'KC': 'Koceljeva',
    'KV': 'Kraljevo',
    'KG': 'Kragujevac',
    'KŽ': 'Knjaževac',
    'KI': 'Kikinda',
    'KL': 'Kladovo',
    'KO': 'Kovin',
    'KU': 'Kula',
    'KŠ': 'Kruševac',
    'LB': 'Lebane',
    'LE': 'Leskovac',
    'LO': 'Loznica',
    'LU': 'Lučani',
    'NV': 'Nova Varoš',
    'NG': 'Negotin',
    'NI': 'Niš',
    'NP': 'Novi Pazar',
    'NS': 'Novi Sad',
    'PA': 'Pančevo',
    'PB': 'Priboj',
    'PŽ': 'Požega',
    'PI': 'Pirot',
    'PK': 'Prokuplje',
    'PN': 'Paraćin',
    'PO': 'Požarevac',
    'PP': 'Prijepolje',
    'PT': 'Petrovac',
    'RA': 'Raška',
    'RU': 'Ruma',
    'SA': 'Senta',
    'SM': 'Sremska Mitrovica',
    'SV': 'Svilajnac',
    'SD': 'Smederevo',
    'SJ': 'Sjenica',
    'SO': 'Sombor',
    'SP': 'Smederevska Palanka',
    'ST': 'Stara Pazova',
    'SU': 'Subotica',
    'SC': 'Surdulica',
    'TO': 'Topola',
    'TS': 'Trstenik',
    'TT': 'Tutin',
    'ĆU': 'Ćuprija',
    'UB': 'Ub',
    'UE': 'Užice',
    'ČA': 'Čačak',
    'ŠA': 'Šabac',
    'ŠI': 'Šid',
  };

  /// The area of [code] (one or two letters), or null when it matches no
  /// code or several.
  static String? lookup(String code) {
    if (code.isEmpty) return null;
    final Set<String> names = <String>{
      for (final MapEntry<String, String> e in _areas.entries)
        if (e.key.startsWith(code)) e.value,
    };
    return names.length == 1 ? names.single : null;
  }

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) => lookup(group('region'));
}
