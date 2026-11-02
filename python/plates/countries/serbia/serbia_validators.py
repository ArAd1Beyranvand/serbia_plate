"""Port of serbia_plate/lib/src/serbia_validators.dart."""
from __future__ import annotations

from plates.core.validators.plate_validator import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length, restriction_verdict)

_LETTERS = frozenset('ABCDEFGHIJKLMNOPRSTUVXZ')
_REGION_LETTERS = frozenset('ABCĆČDEGIJKLMNOPRSŠTUVZŽ')


def _in_alphabet(v: str, n: int, chars: frozenset[str]) -> bool:
    return len(v) == n and all(c in chars for c in v)


def _letters(v: str, n: int) -> bool:
    return _in_alphabet(v, n, _LETTERS)


def _ok(ok: bool, reason: str) -> PlateValidation:
    return PlateValidation.valid() if ok else PlateValidation.invalid(reason)


class SerbiaValidator(GatedPlateValidator):
    gate_group = 'region'

    REASON_REGION = 'The area code is two letters, e.g. BG.'
    REASON_DIGITS = 'Check the number of digits.'
    REASON_LETTERS = 'Check the series letters.'

    def validate(self, entry: PlateEntry) -> PlateValidation:
        id_ = entry.spec.id
        if id_ in ('rs.police', 'rs.military', 'rs.diplomatic'):
            return restriction_verdict(entry) or self._judge_special(entry, id_)
        return super().validate(entry)

    def _judge_special(self, entry: PlateEntry, id_: str) -> PlateValidation:
        g = entry.group
        if id_ == 'rs.police':
            return _ok(is_digits_of_length(g('a'), 3) and is_digits_of_length(g('b'), 3), self.REASON_DIGITS)
        if id_ == 'rs.military':
            return _ok(_letters(g('letter'), 1) and is_digits_of_length(g('digits'), 4), self.REASON_DIGITS)
        return _ok(is_digits_of_length(g('code'), 2) and is_digits_of_length(g('serial'), 3)
                   and (g('tail') == '' or is_digits_of_length(g('tail'), 2)), self.REASON_DIGITS)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        g = entry.group
        if not _in_alphabet(g('region'), 2, _REGION_LETTERS):
            return PlateValidation.invalid(self.REASON_REGION)
        id_ = entry.spec.id
        if id_ == 'rs.private':
            d = g('digits')
            return _ok((is_digits_of_length(d, 3) or is_digits_of_length(d, 4)) and _letters(g('letters'), 2),
                       self.REASON_DIGITS)
        if id_ == 'rs.taxi':
            return _ok(is_digits_of_length(g('digits'), 5), self.REASON_DIGITS)
        if id_ == 'rs.trailer':
            return _ok(_letters(g('letters'), 2) and is_digits_of_length(g('digits'), 3), self.REASON_DIGITS)
        if id_ == 'rs.oldtimer':
            return _ok(g('a') == 'OT' and is_digits_of_length(g('b'), 3), self.REASON_DIGITS)
        if id_ == 'rs.agricultural':
            return _ok(is_digits_of_length(g('a'), 2) and _letters(g('b'), 3), self.REASON_LETTERS)
        return _ok(is_digits_of_length(g('a'), 2) and is_digits_of_length(g('b'), 3), self.REASON_DIGITS)
