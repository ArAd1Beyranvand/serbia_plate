import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';
import 'package:serbia_plate/serbia_plate.dart';

void main() => runApp(
  PlateExampleApp(spec: SerbiaPlates.private, theme: SerbiaThemes.private),
);
