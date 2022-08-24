import 'package:flutter/material.dart';

import '../helpers/colors.dart';

final MaterialColor unisatOrangeColorSwatch =
    MaterialColor(Colors.orange[500]!.value, unisatOrangeColorMap);

ThemeData lightTheme = ThemeData(primarySwatch: unisatOrangeColorSwatch);
ThemeData darkTheme = ThemeData.dark().copyWith(primaryColor: Colors.orange);
