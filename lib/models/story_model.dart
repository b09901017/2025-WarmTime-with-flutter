class StoryModel {
  final String id;
  final String elderId;
  final String title;
  final DateTime dateRecorded;
  final String transcriptPreview; // 文字稿預覽
  final String? aiSummary; // AI整理的故事
  final String? audioUrl; // 錄音檔連結
  final String? caregiverNotes; // 照服員筆記

  StoryModel({
    required this.id,
    required this.elderId,
    required this.title,
    required this.dateRecorded,
    required this.transcriptPreview,
    this.aiSummary,
    this.audioUrl,
    this.caregiverNotes,
  });
}