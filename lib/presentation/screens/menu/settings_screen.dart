import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingsSectionTitle(context, '通知設定'),
          SwitchListTile(
            title: Text('接收新故事提醒', style: AppTextStyles.bodyText1),
            subtitle: Text('當有新的AI整理故事完成時通知我', style: AppTextStyles.caption),
            value: true, // Placeholder
            onChanged: (bool value) {
              // TODO: Implement setting logic
            },
            activeColor: AppColors.primary,
          ),
          SwitchListTile(
            title: Text('接收系統更新通知', style: AppTextStyles.bodyText1),
            value: false, // Placeholder
            onChanged: (bool value) {
              // TODO: Implement setting logic
            },
            activeColor: AppColors.primary,
          ),
          const Divider(height: 30),
          _buildSettingsSectionTitle(context, '錄音設定'),
          ListTile(
            title: Text('錄音品質', style: AppTextStyles.bodyText1),
            subtitle: Text('標準品質', style: AppTextStyles.caption), // Placeholder
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show quality selection dialog
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('錄音品質設定待實現')),
                );
            },
          ),
          const Divider(height: 30),
           _buildSettingsSectionTitle(context, '帳戶安全'),
          ListTile(
            title: Text('變更密碼', style: AppTextStyles.bodyText1),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('變更密碼功能待實現')),
                );
            },
          ),
          ListTile(
            title: Text('兩步驟驗證', style: AppTextStyles.bodyText1),
            subtitle: Text('未啟用', style: AppTextStyles.caption.copyWith(color: AppColors.negative)), // Placeholder
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('兩步驟驗證功能待實現')),
                );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSectionTitle(BuildContext context, String title) {
   return Padding(
     padding: const EdgeInsets.only(top:16.0, bottom: 8.0),
     child: Text(
       title,
       style: AppTextStyles.subtitle1.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.bold),
     ),
   );
 }
}