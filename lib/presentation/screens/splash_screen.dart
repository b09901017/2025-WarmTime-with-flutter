import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/presentation/screens/auth/login_screen.dart'; // 之後會跳轉到登入頁或主頁

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // 模擬載入延遲
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      // TODO: 實際應用中，這裡會檢查登入狀態，決定跳轉到 LoginScreen 或 HomeContainerScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 您可以在這裡放一個大的App Logo
            Image.asset('assets/images/app_logo.png', width: 150, height: 150), // 確保您有這個圖片
            const SizedBox(height: 24),
            Text(
              '暖心時光',
              style: AppTextStyles.headline1.copyWith(color: AppColors.primaryDark),
            ),
            const SizedBox(height: 12),
            Text(
              '記錄點滴，溫暖你我',
              style: AppTextStyles.subtitle1.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}