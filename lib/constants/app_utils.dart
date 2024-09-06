import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stm/theme_provider.dart';

class ApplicationUtils {
  static ThemeData getTheme(BuildContext context) {
    var theme = ThemeData.fallback();
    theme = Theme.of(context);
    return theme;
  }
  static bool isDarkTheme(BuildContext context) {
  return context.select((ThemeStateProvider theme) => theme.isDarkTheme);
}
}
