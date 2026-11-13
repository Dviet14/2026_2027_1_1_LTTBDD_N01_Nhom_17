import 'package:flutter/material.dart';

import 'l10n/app_strings.dart';
import 'l10n/language_controller.dart';
import 'models/user.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'services/local_storage_service.dart';
import 'services/progress_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorageService.initialize();
  await AuthService.initialize();
  await ProgressService.initialize();
  await LanguageController.initialize();

  runApp(const VocabApp());
}

class VocabApp extends StatelessWidget {
  const VocabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageController.current,
      builder: (context, languageCode, _) {
        final strings = AppStrings(languageCode);

        const Color primaryColor = Color(0xFF5547C8);
        const Color backgroundColor = Color(0xFFF5F3FF);

        final ColorScheme colorScheme =
            ColorScheme.fromSeed(
              seedColor: primaryColor,
              brightness: Brightness.light,
            ).copyWith(
              primary: primaryColor,
              secondary: const Color(0xFFF2A65A),
              surface: Colors.white,
            );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: strings.get('appTitle'),

          theme: ThemeData(
            useMaterial3: true,
            colorScheme: colorScheme,

            scaffoldBackgroundColor: backgroundColor,

            appBarTheme: const AppBarTheme(
              backgroundColor: backgroundColor,
              foregroundColor: Color(0xFF292546),
              elevation: 0,
              centerTitle: false,
            ),

            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Color(0xFFE8E3FA)),
              ),
            ),

            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 13,
                ),
              ),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                side: const BorderSide(color: Color(0xFFCDC6F0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFE0DCF0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: primaryColor, width: 1.5),
              ),
            ),

            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: primaryColor,
              linearTrackColor: Color(0xFFE8E3FA),
            ),

            dividerTheme: const DividerThemeData(color: Color(0xFFE8E3FA)),
          ),

          home: ValueListenableBuilder<User?>(
            valueListenable: AuthService.currentUser,
            builder: (context, user, _) {
              return user == null ? const LoginScreen() : const HomeScreen();
            },
          ),
        );
      },
    );
  }
}
