暖心時光 (Warm Heart Time)
一款用生命故事，連結心與心的長照輔助 APP。

「暖心時光」是一款專為台灣長照機構設計的 Flutter 應用程式，旨在幫助新進照服員透過記錄長者的生命故事，快速建立信任與情感連結，從而提升照護品質與工作意義感。

(您可以在這裡放上您 App 最新的主頁面截圖，例如 image_5ef34e.png)
## 專案理念 (Project Vision)

在長照機構中，我們觀察到一個核心問題：新進照服員時常面臨與長者建立關係的困難。長者對於不熟悉的臉孔往往抱持戒心，導致照護工作難以順利推展。同時，照服員的高流動率也使得照護知識與經驗難以有效傳承，家屬亦會擔心長者無法獲得真正個人化的照顧。

我們的理念是，每個長者都是一本厚重的生命故事書。

「暖心時光」希望透過一個簡單易用的工具，引導並協助照服員記錄下這些珍貴的生命故事。這不僅能讓新進照服員快速了解長輩的個性、喜好與人生經歷，更能：

為照服員：將工作從單純的勞務，昇華為「見證並記錄寶貴生命」的神聖使命，從中發掘工作的深層意義，提升職業認同感與留任意願。
為長者：提供一個被傾聽、被理解的機會，肯定其生命的價值，並為他們留下珍貴的生命記錄。
為家屬與機構：透過具體的生命故事，讓家屬安心，並為機構累積無形的文化與知識資產。
核心功能 (Key Features)
一鍵錄音：在主頁面選擇長輩後，點擊大型錄音按鈕即可輕鬆開始記錄對話。
弧形輪播選單：直覺、美觀的弧形滑動介面，方便照服員快速選擇要進行故事記錄的長輩。
引導式對話：主頁面提供可切換的「提示小語」，並在側邊欄提供完整的「引導話題庫」，幫助照服員開啟與長輩的溫暖對話。
生命故事館：集中展示所有長輩的故事檔案，方便隨時查閱過往的記錄。
AI 智能整理 (規劃中)：未來將導入語音轉文字及內容摘要功能，自動將錄音檔整理成易於閱讀的故事文字。
簡單易用的介面：充分考慮照服員工作繁忙的特性，所有操作都力求簡潔、直觀。
目標用戶 (Target Audience)
主要用戶：長照機構的新進照服員（通常較害羞、缺乏經驗）。
間接用戶：機構管理者、長者家屬。
技術棧 (Technology Stack)
本專案採用現代化的跨平台開發技術，確保開發效率與未來擴充性。

前端 (Frontend): Flutter
後端 (Backend): Firebase
資料庫 (Database): Cloud Firestore
檔案儲存 (Storage): Firebase Storage
身份驗證 (Authentication): Firebase Authentication (規劃中)
核心套件 (Key Packages):
permission_handler: 裝置權限管理
path_provider: 檔案路徑管理
google_fonts: 提供美觀的字體
intl: 國際化與日期格式化
目前進度 (Current Status)
截至 2025年6月，專案已完成以下階段性成果：

完整 UI/UX 原型開發：已建構出包含登入頁、主錄音頁、生命故事館、引導話題庫、個人檔案等主要頁面的高擬真UI介面。
核心互動實現：完成了主頁面的弧形輪播、提示語切換等核心互動設計。

下一步計畫 (Next Steps)
我們將基於目前的穩固基礎，逐步實現完整的核心功能，讓 App 從原型走向實用。

實現雲端儲存：將本地錄製完成的音檔上傳至 Firebase Storage。
串接資料庫：將每一則故事的元數據（Metadata），如長輩ID、標題、錄音檔URL等，儲存至 Cloud Firestore。
動態資料載入：讓 App 從 Firestore 動態讀取長輩與故事列表，取代目前的靜態假資料。
AI 功能第一階段：整合 Cloud Speech-to-Text API，實現語音轉文字功能。
使用者回饋與迭代：將 MVP 版本提供給真實使用者進行測試，並根據回饋進行優化。
如何開始 (Getting Started)
若要在本地環境執行此專案，請依照以下步驟操作：

Clone 專案

Bash

git clone https://github.com/b09901017/2025-WarmTime-with-Flutter.git
cd 2025-WarmTime-with-Flutter
安裝 Flutter 環境
請確保您的電腦已安裝並設定好 Flutter SDK。

連接您自己的 Firebase 專案
本專案的 Firebase 設定檔 (firebase_options.dart) 已被 .gitignore 排除。您需要連接到您自己的 Firebase 專案：

Bash

# 安裝/登入 Firebase 工具 (若尚未完成)
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli

# 在專案根目錄執行設定
flutterfire configure
取得專案依賴套件

Bash

flutter pub get
執行 App
連接您的手機或啟動模擬器，然後執行：

Bash

flutter run
專案結構 (Project Structure)
本專案採用清晰的分層架構，以利於維護與擴充。

lib
├── core/             # 核心共用資源 (顏色、字體、輔助工具)
│   ├── constants/
│   └── utils/
├── models/           # 資料模型 (Elder, Story, Prompt)
├── presentation/     # UI 呈現層
│   ├── screens/      # 主要頁面
│   └── widgets/      # 可重用的小組件
└── ...
專案背景 (Project Background)
本專案源自於國立臺灣大學教學發展中心主辦的「113-2 小田野自主學習計畫」。團隊成員基於對長照議題的關懷與改善現況的熱情，組成了「暖心時光」團隊，致力於開發此應用程式。在計畫期間，我們進行了文獻研究、市場競品分析，並透過多次的學習分享與討論，逐步確立了產品的核心價值與開發方向 。




團隊成員 (Team Members)
鄧旭辰 - 技術擔當 (PM / Lead Developer)
黃芷榆 - 市場研究與使用者分析
廖子緹 - 視覺設計與學術理論研究