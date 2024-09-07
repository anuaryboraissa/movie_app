import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  static String convertMinutesToHM(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    String hoursStr = hours > 0 ? '${hours}h ' : '';
    String minutesStr = remainingMinutes > 0 ? '${remainingMinutes}m' : '';

    return '$hoursStr$minutesStr';
  }

  static String convertDateFormat(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd.MM.yy').format(dateTime);

    return formattedDate;
  }
}
