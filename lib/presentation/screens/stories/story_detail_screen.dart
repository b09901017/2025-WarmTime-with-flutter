import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/models/story_model.dart';

class StoryDetailScreen extends StatefulWidget {
  final StoryModel story;
  final String elderName;
  final bool isNewRecording; // To indicate if this is a newly recorded story needing saving

  const StoryDetailScreen({
    super.key,
    required this.story,
    required this.elderName,
    this.isNewRecording = false,
  });

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _transcriptController;
  late TextEditingController _aiSummaryController;
  late TextEditingController _notesController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.story.title);
    // For new recordings, transcript and AI summary might be placeholders or fetched async
    _transcriptController = TextEditingController(
        text: widget.isNewRecording ? "（錄音轉文字內容將顯示於此...）" : widget.story.transcriptPreview);
    _aiSummaryController = TextEditingController(
        text: widget.isNewRecording ? "（AI智能整理故事將顯示於此...）" : widget.story.aiSummary ?? '');
    _notesController = TextEditingController(text: widget.story.caregiverNotes ?? '');
    
    if (widget.isNewRecording) {
      _isEditing = true; // Start in editing mode for new recordings
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _transcriptController.dispose();
    _aiSummaryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveStory() {
    // TODO: Implement actual save logic (e.g., to Firebase)
    setState(() {
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('${widget.isNewRecording ? "故事已儲存！" : "修改已儲存！"} (UI展示)'),
          backgroundColor: AppColors.positive),
    );
    if (widget.isNewRecording) {
        // Potentially pop or navigate differently after initial save
        // For now, just stay on page
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    bool readOnlyOverride = false, // To specifically make a field readonly even in edit mode
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !_isEditing || readOnlyOverride,
      style: AppTextStyles.bodyText1,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true, // Good for multi-line fields
        border: _isEditing ? const OutlineInputBorder() : InputBorder.none,
        focusedBorder: _isEditing ? OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary, width: 1.5)) : InputBorder.none,
        enabledBorder: _isEditing ? OutlineInputBorder(borderSide: BorderSide(color: AppColors.dividerColor, width: 1.0)) : InputBorder.none,
        filled: !_isEditing, // Only fill when not editing to show it's plain text
        fillColor: AppColors.background, // or AppColors.surface if you want a slight box
        contentPadding: _isEditing ? const EdgeInsets.all(12) : const EdgeInsets.symmetric(vertical: 8.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy年M月d日 HH:mm').format(widget.story.dateRecorded);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNewRecording ? '儲存新故事' : widget.story.title),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              tooltip: '編輯故事',
            )
          else
            IconButton(
              icon: const Icon(Icons.save_outlined),
              onPressed: _saveStory,
              tooltip: '儲存修改',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('長輩: ${widget.elderName}', style: AppTextStyles.subtitle1),
            Text('記錄時間: $formattedDate', style: AppTextStyles.caption),
            const SizedBox(height: 20),
            
            _buildSectionTitle('故事標題'),
            _buildTextField(controller: _titleController, label: '為這個故事取個標題'),
            const SizedBox(height: 20),

            // In a real app, audio playback controls would go here
            // For now, just a placeholder
            if (widget.story.audioUrl != null && widget.story.audioUrl!.isNotEmpty || widget.isNewRecording)
            Card(
              color: AppColors.primaryLight.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_outline, size: 30, color: AppColors.primaryDark),
                    const SizedBox(width: 10),
                    Text(widget.isNewRecording ? '播放錄音 (待處理)' : '播放原始錄音', style: AppTextStyles.bodyText1.copyWith(color: AppColors.primaryDark)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('談話文字稿'),
            _buildTextField(controller: _transcriptController, label: '長輩的口述內容', maxLines: 5, readOnlyOverride: true), // Transcript usually not editable directly by caregiver to maintain fidelity
            const SizedBox(height: 4),
            if (_isEditing) Text("提示：文字稿由系統自動生成，如有需要請於下方筆記補充。", style: AppTextStyles.caption.copyWith(color: AppColors.warning)),


            const SizedBox(height: 20),
            _buildSectionTitle('AI 智能整理'),
            _buildTextField(controller: _aiSummaryController, label: 'AI 整理的故事摘要', maxLines: 5),
            const SizedBox(height: 20),

            _buildSectionTitle('照服員筆記'),
            _buildTextField(controller: _notesController, label: '您的觀察與心得 (選填)', maxLines: 3),
            const SizedBox(height: 30),

            if (_isEditing)
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save_alt_outlined),
                  label: Text(widget.isNewRecording ? '儲存這則故事' : '儲存修改'),
                  onPressed: _saveStory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            color: AppColors.primary,
            margin: const EdgeInsets.only(right: 8),
          ),
          Text(title, style: AppTextStyles.headline3.copyWith(fontSize: 18)),
        ],
      ),
    );
  }
}