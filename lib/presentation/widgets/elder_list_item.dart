import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/models/elder_model.dart';

class ElderListItem extends StatelessWidget {
  final ElderModel elder;
  final VoidCallback onTap;

  const ElderListItem({
    super.key,
    required this.elder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias, // Ensures the InkWell ripple effect is contained
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryLight,
                backgroundImage: elder.profileImageUrl != null && elder.profileImageUrl!.startsWith('assets/')
                    ? AssetImage(elder.profileImageUrl!)
                    : (elder.profileImageUrl != null ? NetworkImage(elder.profileImageUrl!) : null) as ImageProvider?,
                child: elder.profileImageUrl == null
                    ? Text(
                        elder.name.isNotEmpty ? elder.name[0] : '?',
                        style: AppTextStyles.headline3.copyWith(color: AppColors.primaryDark),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(elder.name, style: AppTextStyles.headline3.copyWith(fontSize: 18)),
                    const SizedBox(height: 4),
                    Text('房號: ${elder.roomNumber}', style: AppTextStyles.bodyText2),
                    if (elder.bio != null && elder.bio!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        elder.bio!,
                        style: AppTextStyles.caption.copyWith(fontStyle: FontStyle.italic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.auto_stories_outlined, color: AppColors.accent, size: 20),
                  const SizedBox(height: 4),
                  Text('${elder.storyCount}則故事', style: AppTextStyles.caption.copyWith(color: AppColors.accent)),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: AppColors.iconColor),
            ],
          ),
        ),
      ),
    );
  }
}