"""Port of serbia_plate/lib/src/kosovo/src/kosovo_validators.dart."""
from __future__ import annotations

import re

from plates.core.validators.plate_validator import GatedPlateValidator, PlateEntry, PlateValidation

KOSOVO_DISTRICT_NAMES = {
    '01': 'Pristina', '02': 'Mitrovica', '03': 'Peja', '04': 'Prizren',
    '05': 'Ferizaj', '06': 'Gjilan', '07': 'Gjakova',
}

_district = re.compile(r'0[1-7]')
_two_digits = re.compile(r'[0-9]{2}')
_three_digits = re.compile(r'[0-9]{3}')
_two_letters = re.compile(r'[A-Z]{2}')
_district_plate = {'region': _district, 'serial': _three_digits, 'series': _two_letters}
_formats = {
    'xk.private': _district_plate,
    'xk.agriculture': _district_plate,
    'xk.trailer': _district_plate,
    'xk.moped': _district_plate,
    'xk.government': {'agency': re.compile(r'[0-9][A-Z]'), 'serial': _three_digits, 'series': _two_digits},
    'xk.police': {'serial': _three_digits, 'series': _two_digits},
    'xk.emergency': {'service': _three_digits, 'serial': _three_digits, 'series': _two_digits},
    'xk.customs': {'serial': _three_digits, 'series': _two_letters},
    'xk.military': {'unit': re.compile(r'[A-Z]{3}'), 'serial': _three_digits, 'series': _two_digits},
    'xk.unmik': {'serial': _three_digits, 'mark': _two_letters, 'series': _three_digits},
    'xk.diplomatic': {'region': _two_digits, 'mark': _two_letters, 'series': _three_digits},
    'xk.eulex': {'series': re.compile(r'[0-9]{4}')},
}


class KosovoValidator(GatedPlateValidator):
    gate_group = 'series'

    REASON = 'The plate does not match its format.'
    REASON_DISTRICT = 'The district code is 01 to 07.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        fmt = _formats.get(entry.spec.id)
        if fmt is None:
            return PlateValidation.valid()
        for key, rx in fmt.items():
            if not rx.fullmatch(entry.group(key)):
                return PlateValidation.invalid(self.REASON_DISTRICT if key == 'region' else self.REASON)
        return PlateValidation.valid()
