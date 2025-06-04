import 'package:flutter/material.dart';
import 'dart:math' as math; // For PI
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/core/utils/helpers.dart';
import 'package:warm_heart_time_app/models/elder_model.dart';
import 'package:warm_heart_time_app/presentation/screens/recording/start_recording_screen.dart';
import 'package:warm_heart_time_app/presentation/widgets/app_drawer.dart';
import 'package:warm_heart_time_app/presentation/widgets/elder_carousel_item.dart';
import 'package:warm_heart_time_app/presentation/widgets/hint_display_widget.dart';

class MainRecordScreen extends StatefulWidget {
  const MainRecordScreen({super.key});

  @override
  State<MainRecordScreen> createState() => _MainRecordScreenState();
}

class _MainRecordScreenState extends State<MainRecordScreen> {
  late PageController _pageController;
  List<ElderModel> _elders = [];
  List<ElderModel> _filteredElders = []; // For search
  int _selectedIndex = 0; // Index for _filteredElders
  double _currentPage = 0.0;

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  static const double _viewportFraction = 0.55;
  static const double _carouselItemHeight = 220.0;

  @override
  void initState() {
    super.initState();
    _elders = DummyDataHelper.getDummyElders();
    _filteredElders = List.from(_elders); // Start with all elders

    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: _viewportFraction,
    )..addListener(() {
        if (_pageController.page != null) {
          setState(() {
            _currentPage = _pageController.page!;
          });
        }
      });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredElders = List.from(_elders);
      } else {
        _filteredElders = _elders.where((elder) {
          return elder.name.toLowerCase().contains(query) ||
                 (elder.roomNumber).toLowerCase().contains(query);
        }).toList();
      }
      // Reset selection if the list changes significantly
      // A more sophisticated approach might try to keep selection if possible
      if (_filteredElders.isNotEmpty) {
        _selectedIndex = 0;
         _currentPage = 0.0; // Reflect the reset
        if (_pageController.hasClients) {
           _pageController.jumpToPage(0); // Jump to the first item of the filtered list
        }
      } else {
        _selectedIndex = -1; // Indicates no item is selectable
        _currentPage = 0.0;
      }
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(() {
       if (_pageController.page != null) {
          setState(() {
            _currentPage = _pageController.page!;
          });
        }
    });
    _pageController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onAddNewElder() {
    // TODO: Navigate to Add Elder Screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('新增長輩功能待實現')),
    );
    // Example: If you had an AddElderScreen
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddElderScreen())).then((newElder) {
    //   if (newElder != null) {
    //     setState(() {
    //       _elders.add(newElder);
    //       _onSearchChanged(); // Refresh filtered list
    //     });
    //   }
    // });
  }

  void _onRecordPressed() {
    if (_selectedIndex >= 0 && _selectedIndex < _filteredElders.length) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StartRecordingScreen(elder: _filteredElders[_selectedIndex]),
        ),
      );
    } else if (_filteredElders.isEmpty && !_isSearching) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('目前沒有長輩可供選擇，請先新增長輩。')),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請先選擇一位長輩')),
      );
    }
  }

  PreferredSizeWidget _buildSearchAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close, color: AppColors.textOnPrimary), // Changed to close for clarity
        onPressed: () {
          setState(() {
            _isSearching = false;
            _searchController.clear(); // This will trigger _onSearchChanged to reset the list
          });
        },
      ),
      title: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: '搜尋長輩姓名或房號...',
          hintStyle: AppTextStyles.bodyText1.copyWith(color: AppColors.textOnPrimary.withOpacity(0.7)),
          border: InputBorder.none,
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.textOnPrimary),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
        ),
        style: AppTextStyles.bodyText1.copyWith(color: AppColors.textOnPrimary),
      ),
      backgroundColor: AppColors.primaryDark,
    );
  }

  PreferredSizeWidget _buildDefaultAppBar() {
    return AppBar(
      title: Text('暖心時光', style: AppTextStyles.headline3.copyWith(color: AppColors.textOnPrimary)),
      elevation: 0,
      backgroundColor: AppColors.primary, // Ensure default AppBar has a color
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textOnPrimary),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
          tooltip: '搜尋長輩',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool displayCarousel = _filteredElders.isNotEmpty || _isSearching; // Show carousel if there are results or if search is active

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _isSearching ? _buildSearchAppBar() : _buildDefaultAppBar(),
      drawer: const AppDrawer(),
      body: GestureDetector( // To dismiss keyboard when tapping outside search field
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _carouselItemHeight,
              child: displayCarousel
                  ? PageView.builder(
                      controller: _pageController,
                      itemCount: _filteredElders.length + (_isSearching ? 0 : 1), // Add new button only if not searching
                      onPageChanged: (int index) {
                        // Only update selectedIndex if it's a valid elder index
                        if (index < _filteredElders.length) {
                           setState(() {
                            _selectedIndex = index;
                          });
                        } else {
                          // This case is for the "add new" button, don't set selectedIndex
                           setState(() {
                            _selectedIndex = -1; // Or a specific value indicating add new button focus
                          });
                        }
                      },
                      itemBuilder: (context, index) {
                        bool isAddNewButton = !_isSearching && (index == _filteredElders.length);
                        double diff = (index - _currentPage);
                        double scale = math.max(0.7, 1.0 - (diff.abs() * 0.25));
                        double yOffset = diff.abs() * 30.0;
                        double rotationAngle = diff * -0.08; // Reduced rotation for subtlety

                        if (isAddNewButton) {
                          return Transform.scale(
                            scale: scale, // Apply similar transform for consistency
                             alignment: Alignment.center,
                            child: InkWell(
                              onTap: _onAddNewElder,
                              child: const ElderCarouselItem(
                                isSelected: false, // Should not be "selected"
                                isAddNewButton: true,
                              ),
                            ),
                          );
                        }
                        
                        // This check is important if _filteredElders can be empty while displayCarousel is true (e.g. during search with no results)
                        if (_filteredElders.isEmpty || index >= _filteredElders.length) {
                           // This should ideally not be reached if itemCount is correct and _filteredElders is empty unless searching
                           return Center(
                            child: _isSearching ? 
                                Text("沒有找到符合的長輩", style: AppTextStyles.subtitle1.copyWith(color: AppColors.textSecondary)) : 
                                const SizedBox.shrink(), // Or some placeholder when search results are empty
                          );
                        }

                        ElderModel elder = _filteredElders[index];
                        bool isCurrentlySelectedInView = (_selectedIndex == index);

                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015) // Perspective
                            ..translate(0.0, yOffset, 0.0)
                            ..scale(scale)
                            ..rotateY(rotationAngle),
                          alignment: Alignment.center,
                          child: ElderCarouselItem(
                            elder: elder,
                            isSelected: isCurrentlySelectedInView,
                          ),
                        );
                      },
                    )
                  : Center( // Empty state for carousel when no elders and not searching
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.groups_2_outlined, size: 60, color: AppColors.textSecondary.withOpacity(0.5)),
                            const SizedBox(height: 16),
                            Text(
                              '還沒有長輩的資料喔！',
                              style: AppTextStyles.subtitle1.copyWith(color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add_circle_outline),
                              label: const Text('新增第一位長輩'),
                              onPressed: _onAddNewElder,
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
            const Spacer(flex: 1),
            const HintDisplayWidget(),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: InkWell(
                onTap: _onRecordPressed,
                customBorder: const CircleBorder(),
                splashColor: AppColors.primaryLight.withOpacity(0.5),
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  color: AppColors.primary,
                  shadowColor: AppColors.primaryDark.withOpacity(0.7),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.mic, size: 50, color: AppColors.textOnPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}