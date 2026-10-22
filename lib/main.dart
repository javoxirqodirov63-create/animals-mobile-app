import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_colors.dart';
import 'core/services/supabase_service.dart';
import 'providers/listing_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const AnimalsApp());
}

class AnimalsApp extends StatelessWidget {
  const AnimalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListingProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final config = themeProvider.config;
          return MaterialApp(
            title: 'Animals-uz',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: config.primary,
                brightness: Brightness.light,
                primary: config.primary,
                surface: config.cardColor,
                error: AppColors.error,
              ),
              scaffoldBackgroundColor: config.background,
              appBarTheme: AppBarTheme(
                backgroundColor: config.cardColor,
                elevation: 0,
                scrolledUnderElevation: 0,
                iconTheme: IconThemeData(color: config.textPrimary),
                titleTextStyle: TextStyle(
                  color: config.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              cardTheme: CardThemeData(
                color: config.cardColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(config.cardRadius),
                ),
              ),
            ),
            home: const MainNavigationScreen(),
          );
        },
      ),
    );
  }
}
