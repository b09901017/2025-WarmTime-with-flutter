import 'package:warm_heart_time_app/models/elder_model.dart';
import 'package:warm_heart_time_app/models/story_model.dart';
import 'package:warm_heart_time_app/models/prompt_model.dart';

class DummyDataHelper {
  static List<ElderModel> getDummyElders() {
    return [
      ElderModel(
        id: 'elder_001',
        name: '王秀英 阿嬤',
        roomNumber: 'A101',
        profileImageUrl: 'assets/images/profile_placeholder.png', // 使用佔位圖片
        bio: '喜歡聽台語歌，年輕時是裁縫師。',
        storyCount: 3,
      ),
      ElderModel(
        id: 'elder_002',
        name: '李文雄 阿公',
        roomNumber: 'B203',
        profileImageUrl: 'assets/images/profile_placeholder.png',
        bio: '以前是小學老師，愛下象棋。',
        storyCount: 5,
      ),
      ElderModel(
        id: 'elder_003',
        name: '陳美惠 阿嬤',
        roomNumber: 'C305',
        profileImageUrl: 'assets/images/profile_placeholder.png',
        bio: '愛看歌仔戲，拿手菜是滷肉。',
        storyCount: 2,
      ),
    ];
  }

  static List<StoryModel> getDummyStories(String elderId) {
    // 實際應用中，這裡會根據 elderId 從資料庫獲取
    return [
      StoryModel(
        id: '${elderId}_story_001',
        elderId: elderId,
        title: '童年回憶：抓蟋蟀的下午',
        dateRecorded: DateTime.now().subtract(const Duration(days: 5)),
        transcriptPreview: '那時候啊，阮攏嘛揪厝邊頭尾的囡仔，做伙去田埂邊仔...',
        aiSummary: '記錄了長者童年時期與鄰居小孩一同在田邊抓蟋蟀的快樂時光，展現了純真的童趣。',
        audioUrl: '', // UI階段留空
      ),
      StoryModel(
        id: '${elderId}_story_002',
        elderId: elderId,
        title: '我的第一份工',
        dateRecorded: DateTime.now().subtract(const Duration(days: 2)),
        transcriptPreview: '我第一份工是在紡織廠，雖然辛苦，但是很充實...',
        aiSummary: '描述了長者在紡織廠的第一份工作經歷，雖然辛苦但充滿成就感。',
        audioUrl: '',
      ),
    ];
  }

  static List<PromptModel> getDummyPrompts() {
    return [
      PromptModel(id: 'p001', category: '童年往事', question: '阿公/阿嬤，您小時候最喜歡玩的遊戲是什麼？'),
      PromptModel(id: 'p002', category: '青春歲月', question: '您年輕時有沒有特別難忘的旅行經驗？'),
      PromptModel(id: 'p003', category: '工作生涯', question: '您覺得工作中最有成就感的事情是什麼？'),
      PromptModel(id: 'p004', category: '家庭生活', question: '家裡有沒有什麼特別的傳統或習俗？'),
      PromptModel(id: 'p005', category: '興趣愛好', question: '您平常最喜歡做些什麼休閒活動呢？'),
      PromptModel(id: 'p006', category: '人生智慧', question: '如果能給年輕人一句話，您會想說什麼？'),
    ];
  }
}