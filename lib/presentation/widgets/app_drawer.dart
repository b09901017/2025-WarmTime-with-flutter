import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/presentation/screens/auth/login_screen.dart';
import 'package:warm_heart_time_app/presentation/screens/menu/life_story_hall_screen.dart';
import 'package:warm_heart_time_app/presentation/screens/menu/my_profile_screen.dart';
import 'package:warm_heart_time_app/presentation/screens/menu/prompts_library_screen.dart';
import 'package:warm_heart_time_app/presentation/screens/menu/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _logout(BuildContext context) {
    // TODO: Implement actual logout logic (clear session, etc.)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data for drawer header
    const String caregiverName = "林照服員";
    const String caregiverEmail = "caregiver@example.com";
    const String profileImageUrl = 'assets/images/profile_placeholder.png';

    return Drawer(
      backgroundColor: AppColors.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(caregiverName, style: AppTextStyles.headline3.copyWith(color: AppColors.textOnPrimary)),
            accountEmail: Text(caregiverEmail, style: AppTextStyles.bodyText2.copyWith(color: AppColors.textOnPrimary.withOpacity(0.8))),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(profileImageUrl),
              backgroundColor: AppColors.primaryLight,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            otherAccountsPictures: [
              IconButton(
                icon: Icon(Icons.brightness_6_outlined, color: AppColors.textOnPrimary.withOpacity(0.8)),
                onPressed: () {
                  // TODO: Implement theme toggle
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('主題切換功能待實現')),
                  );
                },
              )
            ],
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.auto_stories_outlined, // 或使用更貼切的圖示，如 PhotoAlbum, CollectionsBookmark
            text: '生命故事館',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LifeStoryHallScreen())),
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.lightbulb_outline, // 或 QuestionAnswerOutlined
            text: '引導話題庫',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PromptsLibraryScreen())),
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.person_outline,
            text: '我的檔案',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyProfileScreen())),
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.settings_outlined,
            text: '設定',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
          const Divider(color: AppColors.dividerColor, indent: 16, endIndent: 16),
          _buildDrawerItem(
            context: context,
            icon: Icons.logout,
            text: '登出',
            color: AppColors.negative.withOpacity(0.8),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primaryDark, size: 26),
      title: Text(text, style: AppTextStyles.bodyText1.copyWith(color: color ?? AppColors.textPrimary, fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}