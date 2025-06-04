import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/core/utils/helpers.dart';
import 'package:warm_heart_time_app/models/prompt_model.dart';
import 'package:warm_heart_time_app/presentation/widgets/prompt_card.dart'; // Re-use existing widget
import 'package:warm_heart_time_app/core/constants/app_colors.dart';


class PromptsLibraryScreen extends StatefulWidget {
  const PromptsLibraryScreen({super.key});

  @override
  State<PromptsLibraryScreen> createState() => _PromptsLibraryScreenState();
}

class _PromptsLibraryScreenState extends State<PromptsLibraryScreen> {
  late List<PromptModel> _allPrompts;
  List<PromptModel> _filteredPrompts = [];
  final TextEditingController _searchController = TextEditingController();
   String? _selectedCategory;


  @override
  void initState() {
    super.initState();
    _allPrompts = DummyDataHelper.getDummyPrompts();
    _filteredPrompts = _allPrompts;
    _searchController.addListener(() {
      _filterPromptsList();
    });
  }

 List<String> get _categories {
   return _allPrompts.map((p) => p.category).toSet().toList()..sort();
 }

  void _filterPromptsList() {
    final query = _searchController.text.toLowerCase();
    setState(() {
       _filteredPrompts = _allPrompts.where((prompt) {
       final matchesCategory = _selectedCategory == null || prompt.category == _selectedCategory;
       final matchesQuery = query.isEmpty ||
                            prompt.question.toLowerCase().contains(query) ||
                            prompt.category.toLowerCase().contains(query);
       return matchesCategory && matchesQuery;
     }).toList();
    });
  }

 @override
 void dispose(){
   _searchController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('引導話題庫'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜尋問題或類別...',
                prefixIcon: const Icon(Icons.search, color: AppColors.iconColor),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
         if (_categories.length > 1)
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
           child: SizedBox(
             height: 40,
             child: ListView(
               scrollDirection: Axis.horizontal,
               children: [
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0),
                   child: ChoiceChip(
                     label: const Text('全部主題'),
                     selected: _selectedCategory == null,
                     onSelected: (selected) {
                       setState(() {
                         _selectedCategory = null;
                         _filterPromptsList();
                       });
                     },
                     selectedColor: AppColors.primaryLight,
                     labelStyle: AppTextStyles.bodyText2.copyWith(
                       color: _selectedCategory == null ? AppColors.primaryDark : AppColors.textSecondary,
                     ),
                   ),
                 ),
                 ..._categories.map((category) => Padding(
                   padding: const EdgeInsets.only(right: 8.0),
                   child: ChoiceChip(
                     label: Text(category),
                     selected: _selectedCategory == category,
                     onSelected: (selected) {
                       setState(() {
                         _selectedCategory = selected ? category : null;
                         _filterPromptsList();
                       });
                     },
                     selectedColor: AppColors.primaryLight,
                     labelStyle: AppTextStyles.bodyText2.copyWith(
                       color: _selectedCategory == category ? AppColors.primaryDark : AppColors.textSecondary,
                     ),
                   ),
                 )),
               ],
             ),
           ),
         ),
          Expanded(
            child: _filteredPrompts.isEmpty
                ? Center(
                    child: Text(
                      _searchController.text.isNotEmpty || _selectedCategory != null ? '找不到符合條件的話題' : '目前沒有引導話題',
                      style: AppTextStyles.subtitle1.copyWith(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
                    itemCount: _filteredPrompts.length,
                    itemBuilder: (context, index) {
                      final prompt = _filteredPrompts[index];
                      return PromptCard( // Re-using the existing widget
                        prompt: prompt,
                        onSelect: () {
                          // Optional: Copy to clipboard or other interaction
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('提示已選取：${prompt.question}')),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}