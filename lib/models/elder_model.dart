class ElderModel {
  final String id;
  final String name;
  final String roomNumber;
  final String? profileImageUrl;
  final String? bio; // 簡短介紹
  final int storyCount; // 故事數量

  ElderModel({
    required this.id,
    required this.name,
    required this.roomNumber,
    this.profileImageUrl,
    this.bio,
    this.storyCount = 0,
  });
}