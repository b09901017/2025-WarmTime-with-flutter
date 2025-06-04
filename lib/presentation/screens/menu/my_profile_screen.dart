import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/presentation/screens/auth/login_screen.dart'; // For logout

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  // Dummy data for profile
  final String caregiverName = "林佳慧";
  final String caregiverId = "TWC00789";
  final String institutionName = "幸福長照中心";
  final String profileImageUrl = 'assets/images/profile_placeholder.png';

  void _logout(BuildContext context) {
    // TODO: Implement actual logout logic
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的檔案'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundColor: AppColors.primaryLight.withOpacity(0.7),
              backgroundImage: AssetImage(profileImageUrl),
            ),
            const SizedBox(height: 20),
            Text(caregiverName, style: AppTextStyles.headline2.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('照服員編號: $caregiverId', style: AppTextStyles.subtitle1),
            const SizedBox(height: 4),
            Text('服務機構: $institutionName', style: AppTextStyles.subtitle2.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 40),
            _buildProfileOption(
              context,
              icon: Icons.edit_outlined,
              title: '編輯個人資料',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('編輯個人資料功能待實現')),
                );
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.lock_reset_outlined,
              title: '修改密碼',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('修改密碼功能待實現')),
                );
              },
            ),
            // Merged settings related items here or keep SettingsScreen separate
            _buildProfileOption(
              context,
              icon: Icons.info_outline,
              title: '關於暖心時光',
              onTap: () {
                 showAboutDialog(
                    context: context,
                    applicationName: '暖心時光',
                    applicationVersion: '1.1.0 (Arc UI Demo)',
                    applicationLegalese: '© 2025 Your Warm Heart Org',
                    applicationIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/app_logo.png', width: 48),
                    ),
                    children: [
                      const SizedBox(height: 16),
                      Text('記錄點滴，溫暖你我。', style: AppTextStyles.bodyText2)
                    ]
                 );
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: AppColors.textOnPrimary),
              label: Text('登出帳號', style: AppTextStyles.button.copyWith(color: AppColors.textOnPrimary)),
              onPressed: () => _logout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.negative.withOpacity(0.9),
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryDark, size: 24),
        title: Text(title, style: AppTextStyles.bodyText1.copyWith(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.iconColor, size: 22),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
    );
  }
}