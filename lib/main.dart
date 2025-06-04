import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/presentation/screens/splash_screen.dart';
// import 'package:warm_heart_time_app/routes/app_router.dart'; // 如果使用命名路由

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '暖心時光',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          background: AppColors.background,
          surface: AppColors.surface,
          onPrimary: AppColors.textOnPrimary,
          onSecondary: AppColors.textOnAccent,
          onBackground: AppColors.textPrimary,
          onSurface: AppColors.textPrimary,
          error: AppColors.negative,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary, // For title and icons
          elevation: 1.0,
          titleTextStyle: AppTextStyles.headline3.copyWith(color: AppColors.textOnPrimary),
          iconTheme: const IconThemeData(color: AppColors.textOnPrimary), // For back button, etc.
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.headline1,
          displayMedium: AppTextStyles.headline2,
          displaySmall: AppTextStyles.headline3,
          headlineMedium: AppTextStyles.headline3, // Often used by AppBar title
          titleLarge: AppTextStyles.subtitle1, // Often used by ListTile title
          titleMedium: AppTextStyles.subtitle2,
          bodyLarge: AppTextStyles.bodyText1,
          bodyMedium: AppTextStyles.bodyText2, // Default text style
          labelLarge: AppTextStyles.button, // For buttons
          bodySmall: AppTextStyles.caption,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            textStyle: AppTextStyles.button,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColors.cardBackground,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          labelStyle: AppTextStyles.bodyText2.copyWith(color: AppColors.textSecondary),
          floatingLabelStyle: AppTextStyles.bodyText2.copyWith(color: AppColors.primary),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
          unselectedLabelStyle: AppTextStyles.caption,
          type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // 起始頁面
      // onGenerateRoute: AppRouter.generateRoute, // 如果使用命名路由
      // initialRoute: '/', // 如果使用命名路由
    );
  }
}