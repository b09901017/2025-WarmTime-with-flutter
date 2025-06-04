import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/core/utils/helpers.dart';
import 'package:warm_heart_time_app/models/elder_model.dart';
import 'package:warm_heart_time_app/presentation/screens/elders/elder_profile_screen.dart';
import 'package:warm_heart_time_app/presentation/widgets/elder_list_item.dart'; // Re-use existing widget
import 'package:warm_heart_time_app/core/constants/app_colors.dart';


class LifeStoryHallScreen extends StatefulWidget {
  const LifeStoryHallScreen({super.key});

  @override
  State<LifeStoryHallScreen> createState() => _LifeStoryHallScreenState();
}

class _LifeStoryHallScreenState extends State<LifeStoryHallScreen> {
  late List<ElderModel> _elders;
  List<ElderModel> _filteredElders = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _elders = DummyDataHelper.getDummyElders();
    _filteredElders = _elders;
    _searchController.addListener(() {
      _filterEldersList();
    });
  }

 void _filterEldersList() {
   final query = _searchController.text.toLowerCase();
   setState(() {
     if (query.isEmpty) {
       _filteredElders = _elders;
     } else {
       _filteredElders = _elders.where((elder) {
         return elder.name.toLowerCase().contains(query) ||
                elder.roomNumber.toLowerCase().contains(query);
       }).toList();
     }
   });
 }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToElderProfile(ElderModel elder) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ElderProfileScreen(elder: elder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('生命故事館'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜尋長輩姓名或房號...',
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
        )
      ),
      body: _filteredElders.isEmpty
          ? Center(
              child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text(
                  _searchController.text.isNotEmpty ? '找不到符合條件的長輩' : '目前沒有長輩資料。\n您可以從主頁新增長輩。',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle1.copyWith(color: AppColors.textSecondary),
                ),
              )
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: _filteredElders.length,
              itemBuilder: (context, index) {
                final elder = _filteredElders[index];
                return ElderListItem( // Re-using the existing widget
                  elder: elder,
                  onTap: () => _navigateToElderProfile(elder),
                );
              },
            ),
    );
  }
}