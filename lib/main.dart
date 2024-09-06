import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/screens/registration_screen.dart';
import 'package:movie_app/stm/sign_in_provider.dart';
import 'package:movie_app/stm/theme_provider.dart';
import 'package:provider/provider.dart';

import 'constants/theme_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeStateProvider>(
        create: (_) => ThemeStateProvider()),
    ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider()),
  ], child: const MovieStreamingApp()));

  //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent, // Make status bar transparent
  //   systemNavigationBarColor: Colors.black, // Set navigation bar color (optional)
  //   statusBarIconBrightness: Brightness.light, // Adjust status bar icon colors for dark background
  //   systemNavigationBarIconBrightness: Brightness.light, // Adjust nav bar icon colors for dark background
  // ));

  // // Enable fullscreen without any overlays
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class MovieStreamingApp extends StatefulWidget {
  const MovieStreamingApp({super.key});

  @override
  State<MovieStreamingApp> createState() => _MovieStreamingAppState();
}

class _MovieStreamingAppState extends State<MovieStreamingApp> {
  // This widget is the root of your application.
  @override
  void didChangeDependencies() {
    context.read<ThemeStateProvider>().getDarkTheme();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStateProvider>(builder: (context, theme, child) {
      return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Streaming App',
              darkTheme: ThemeConfig.darkTheme,
              theme: ThemeConfig.lightTheme,
              themeMode: ThemeMode.system == ThemeMode.dark
                  ? ThemeMode.dark
                  : theme.isDarkTheme
                      ? ThemeMode.dark
                      : ThemeMode.light,
              home: const RegistrationScreen(),
            );
          });
    });
  }
}
