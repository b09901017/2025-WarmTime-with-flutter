import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add intl package to pubspec.yaml for date formatting
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/models/story_model.dart';

class StoryCard extends StatelessWidget {
  final StoryModel story;
  final VoidCallback onTap;

  const StoryCard({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy年M月d日').format(story.dateRecorded);
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                story.title,
                style: AppTextStyles.headline3.copyWith(fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '記錄日期: $formattedDate',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 10),
              Text(
                story.transcriptPreview,
                style: AppTextStyles.bodyText2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (story.aiSummary != null && story.aiSummary!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.psychology_outlined, size: 16, color: AppColors.accent),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'AI摘要: ${story.aiSummary}',
                        style: AppTextStyles.caption.copyWith(color: AppColors.accent, fontStyle: FontStyle.italic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '查看詳情 >',
                  style: AppTextStyles.button.copyWith(fontSize: 14, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}