import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/core/utils/helpers.dart';
import 'package:warm_heart_time_app/models/elder_model.dart';
import 'package:warm_heart_time_app/models/story_model.dart';
import 'package:warm_heart_time_app/presentation/screens/recording/start_recording_screen.dart';
import 'package:warm_heart_time_app/presentation/screens/stories/story_detail_screen.dart';
import 'package:warm_heart_time_app/presentation/widgets/story_card.dart';

class ElderProfileScreen extends StatefulWidget {
  final ElderModel elder;
  const ElderProfileScreen({super.key, required this.elder});

  @override
  State<ElderProfileScreen> createState() => _ElderProfileScreenState();
}

class _ElderProfileScreenState extends State<ElderProfileScreen> {
  late List<StoryModel> _stories;

  @override
  void initState() {
    super.initState();
    _stories = DummyDataHelper.getDummyStories(widget.elder.id);
  }

  void _navigateToStartRecording() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StartRecordingScreen(elder: widget.elder),
      ),
    );
    // TODO: 錄音完成後，可能需要刷新此頁面的故事列表
  }

  void _navigateToStoryDetail(StoryModel story) {
     Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryDetailScreen(story: story, elderName: widget.elder.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.elder.name),
      ),
      body: CustomScrollView( // Use CustomScrollView for collapsible header effect later if needed
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primaryLight,
                        backgroundImage: widget.elder.profileImageUrl != null && widget.elder.profileImageUrl!.startsWith('assets/')
                            ? AssetImage(widget.elder.profileImageUrl!)
                            : (widget.elder.profileImageUrl != null ? NetworkImage(widget.elder.profileImageUrl!) : null) as ImageProvider?,
                        child: widget.elder.profileImageUrl == null
                            ? Text(
                                widget.elder.name.isNotEmpty ? widget.elder.name[0] : '?',
                                style: AppTextStyles.headline1.copyWith(color: AppColors.primaryDark),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.elder.name, style: AppTextStyles.headline2),
                            const SizedBox(height: 4),
                            Text('房號: ${widget.elder.roomNumber}', style: AppTextStyles.subtitle1),
                          ],
                        ),
                      ),
                      // Potentially an edit button for elder info (for admins)
                      // IconButton(icon: Icon(Icons.edit_outlined), onPressed: () {})
                    ],
                  ),
                  if (widget.elder.bio != null && widget.elder.bio!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text('關於 ${widget.elder.name}:', style: AppTextStyles.subtitle1.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(widget.elder.bio!, style: AppTextStyles.bodyText1),
                  ],
                  const SizedBox(height: 20),
                  Divider(color: AppColors.dividerColor.withOpacity(0.5)),
                  const SizedBox(height: 10),
                  Text(
                    '生命故事集 (${_stories.length})',
                    style: AppTextStyles.headline3.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          _stories.isEmpty
              ? SliverFillRemaining( // Use SliverFillRemaining for empty state in CustomScrollView
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sentiment_dissatisfied_outlined, size: 60, color: AppColors.textSecondary),
                          const SizedBox(height:16),
                          Text(
                            '還沒有為 ${widget.elder.name} 記錄任何故事。',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.subtitle1,
                          ),
                          const SizedBox(height:16),
                           Text(
                            '點擊下方的按鈕開始第一次記錄吧！',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final story = _stories[index];
                      return StoryCard(
                        story: story,
                        onTap: () => _navigateToStoryDetail(story),
                      );
                    },
                    childCount: _stories.length,
                  ),
                ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)), // Space for FAB
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToStartRecording,
        backgroundColor: AppColors.accent,
        icon: const Icon(Icons.mic_none_outlined, color: AppColors.textOnAccent),
        label: Text('開始記錄新故事', style: AppTextStyles.button.copyWith(color: AppColors.textOnAccent)),
      ),
    );
  }
}