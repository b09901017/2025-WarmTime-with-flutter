import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/core/utils/helpers.dart';
import 'package:warm_heart_time_app/models/elder_model.dart';
import 'package:warm_heart_time_app/models/prompt_model.dart';
import 'package:warm_heart_time_app/presentation/screens/stories/story_detail_screen.dart'; // For after recording
import 'package:warm_heart_time_app/models/story_model.dart'; // Add import for StoryModel

// Enum to manage recording states
enum RecordingState { idle, recording, paused, finished }

class StartRecordingScreen extends StatefulWidget {
  final ElderModel elder;
  const StartRecordingScreen({super.key, required this.elder});

  @override
  State<StartRecordingScreen> createState() => _StartRecordingScreenState();
}

class _StartRecordingScreenState extends State<StartRecordingScreen> {
  RecordingState _recordingState = RecordingState.idle;
  List<PromptModel> _prompts = [];
  PromptModel? _selectedPrompt;
  String _timerDisplay = "00:00"; // Placeholder for timer

  // TODO: Add actual recording logic and timer update

  @override
  void initState() {
    super.initState();
    _prompts = DummyDataHelper.getDummyPrompts().take(3).toList(); // Take a few prompts for display
  }

  void _toggleRecording() {
    setState(() {
      if (_recordingState == RecordingState.idle || _recordingState == RecordingState.paused) {
        _recordingState = RecordingState.recording;
        // TODO: Start actual recording & timer
        _timerDisplay = "00:01"; // Simulate timer start
      } else if (_recordingState == RecordingState.recording) {
        _recordingState = RecordingState.paused; // Or directly to finished for simplicity
        // TODO: Pause actual recording & timer
      }
    });
  }

  void _stopRecording() {
    setState(() {
      _recordingState = RecordingState.finished;
      // TODO: Stop actual recording, save file, etc.
    });
    // Navigate to review/save screen
    _showSaveDialog();
  }

  void _showSaveDialog() {
    // For UI demo, directly navigate to a dummy story detail screen
    // In real app, this would involve saving the recording and then navigating
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('錄音完成 (UI展示) - 即將跳轉到故事預覽頁面')),
    );
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        // Create a dummy story to show the detail page
        final dummyStory = StoryModel(
          id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
          elderId: widget.elder.id,
          title: _selectedPrompt?.question ?? '新錄製的故事 ${DateTime.now().toShortDateString()}',
          dateRecorded: DateTime.now(),
          transcriptPreview: '這是錄音轉成的文字稿預覽... (此處應為真實轉錄內容)',
          aiSummary: 'AI 正在努力為您整理故事摘要... (此處應為AI生成內容)',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => StoryDetailScreen(story: dummyStory, elderName: widget.elder.name, isNewRecording: true),
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('為 ${widget.elder.name} 記錄'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (_recordingState == RecordingState.recording || _recordingState == RecordingState.paused) {
              _showExitConfirmationDialog();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Top section: Elder info and prompts
            Column(
              children: [
                Text('正在為 ${widget.elder.name} 記錄新的生命故事', style: AppTextStyles.subtitle1),
                const SizedBox(height: 20),
                if (_recordingState == RecordingState.idle) ...[
                  Text('可以參考以下話題開始：', style: AppTextStyles.bodyText1),
                  const SizedBox(height: 10),
                  Container(
                    height: 150, // Adjust height as needed
                    child: ListView.builder(
                      itemCount: _prompts.length,
                      itemBuilder: (context, index) {
                        final prompt = _prompts[index];
                        return Card(
                          color: _selectedPrompt == prompt ? AppColors.primaryLight.withOpacity(0.5) : AppColors.cardBackground,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(prompt.question, style: AppTextStyles.bodyText2, maxLines: 2, overflow: TextOverflow.ellipsis,),
                            onTap: () {
                              setState(() {
                                _selectedPrompt = prompt;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ] else ...[
                  // Display selected prompt or recording status
                  if (_selectedPrompt != null) Text('話題: ${_selectedPrompt!.question}', style: AppTextStyles.bodyText1, textAlign: TextAlign.center,),
                  const SizedBox(height: 20),
                  Text(_timerDisplay, style: AppTextStyles.headline1.copyWith(fontSize: 48, color: AppColors.primaryDark)),
                   Text(
                    _recordingState == RecordingState.recording ? '錄音中...' : (_recordingState == RecordingState.paused ? '已暫停' : '準備開始'),
                    style: AppTextStyles.subtitle1.copyWith(color: AppColors.accent),
                  ),
                ],
              ],
            ),
            
            // Bottom section: Recording controls
            if (_recordingState != RecordingState.finished)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  if (_recordingState == RecordingState.recording || _recordingState == RecordingState.paused)
                    IconButton(
                      icon: const Icon(Icons.stop_circle_outlined, color: AppColors.negative, size: 50),
                      onPressed: _stopRecording,
                      tooltip: '結束錄音',
                    ),
                  
                  InkWell(
                    onTap: _toggleRecording,
                    customBorder: const CircleBorder(),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _recordingState == RecordingState.recording ? AppColors.negative.withOpacity(0.2) : AppColors.primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _recordingState == RecordingState.recording ? Icons.pause : Icons.mic,
                        size: 60,
                        color: _recordingState == RecordingState.recording ? AppColors.negative : AppColors.primary,
                      ),
                    ),
                  ),

                  // Placeholder for other controls like restart or flag
                   SizedBox(
                    width: 50, // to balance the stop button
                    child: (_recordingState == RecordingState.recording || _recordingState == RecordingState.paused) ? 
                      IconButton(
                        icon: Icon(Icons.flag_outlined, color: AppColors.iconColor.withOpacity(0.5), size: 30),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('標記功能待實現')),
                          );
                        },
                        tooltip: '標記此刻 (UI Demo)',
                      )
                      : null,
                   )
                ],
              ),
            )
            else 
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    const Icon(Icons.check_circle_outline, color: AppColors.positive, size: 80),
                    const SizedBox(height: 16),
                    Text('錄音已完成！', style: AppTextStyles.headline3),
                    const SizedBox(height: 8),
                    Text('正在為您處理檔案...', style: AppTextStyles.subtitle1),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showExitConfirmationDialog() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認離開?', style: AppTextStyles.headline3),
          content: Text('錄音尚未儲存，確定要離開嗎？目前的錄音內容將會遺失。', style: AppTextStyles.bodyText1),
          actions: <Widget>[
            TextButton(
              child: Text('取消', style: AppTextStyles.button.copyWith(color: AppColors.textSecondary)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('確定離開', style: AppTextStyles.button.copyWith(color: AppColors.negative)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        );
      },
    );
    if (confirm == true && mounted) {
      Navigator.of(context).pop();
    }
  }
}

// Helper to format DateTime to short string (could be in utils)
extension DateTimeExtension on DateTime {
  String toShortDateString() {
    return "${this.year}/${this.month.toString().padLeft(2, '0')}/${this.day.toString().padLeft(2, '0')}";
  }
}