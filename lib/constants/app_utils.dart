import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants/app_assets.dart';
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

  static Map<String, String> extractCityAndCountry(String location) {
    List<String> parts =
        location.split(',').map((part) => part.trim()).toList();

    String city = parts.first;
    String country = parts.last;

    return {
      'city': city,
      'country': country,
    };
  }

  static String getRandomBackgroundImages() {
    List<String> images = [
      ApplicationAssets.img,
      ApplicationAssets.img1,
      ApplicationAssets.img2,
      ApplicationAssets.img3,
      ApplicationAssets.img4,
      ApplicationAssets.img5,
      ApplicationAssets.img6,
      ApplicationAssets.img7,
      ApplicationAssets.img8
    ];
    return images[Random().nextInt(images.length)];
  }
}
