import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/models/prompt_model.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/core/utils/helpers.dart'; // Assuming getDummyPrompts is here

class HintDisplayWidget extends StatefulWidget {
  const HintDisplayWidget({super.key});

  @override
  State<HintDisplayWidget> createState() => _HintDisplayWidgetState();
}

class _HintDisplayWidgetState extends State<HintDisplayWidget> {
  late List<PromptModel> _prompts;
  int _currentPromptIndex = 0;

  @override
  void initState() {
    super.initState();
    _prompts = DummyDataHelper.getDummyPrompts();
    if (_prompts.isEmpty) {
     // Add a default prompt if list is empty to avoid errors
     _prompts.add(PromptModel(id: "default", category: "提示", question: "今天想聊些什麼呢？"));
    }
  }

  void _nextPrompt() {
    if (_prompts.isEmpty) return;
    setState(() {
      _currentPromptIndex = (_currentPromptIndex + 1) % _prompts.length;
    });
  }

  void _previousPrompt() {
    if (_prompts.isEmpty) return;
    setState(() {
      _currentPromptIndex = (_currentPromptIndex - 1 + _prompts.length) % _prompts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_prompts.isEmpty) {
      return const SizedBox.shrink(); // Or some placeholder if no prompts
    }
    final currentPrompt = _prompts[_currentPromptIndex];

    return Card(
      elevation: 2.0,
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        constraints: const BoxConstraints(minHeight: 100),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: AppColors.primary, size: 30),
              onPressed: _previousPrompt,
              tooltip: '上一個提示',
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   if (currentPrompt.category.isNotEmpty)
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                       decoration: BoxDecoration(
                         color: AppColors.accent.withOpacity(0.1),
                         borderRadius: BorderRadius.circular(6),
                       ),
                       child: Text(
                         currentPrompt.category,
                         style: AppTextStyles.caption.copyWith(color: AppColors.accent, fontWeight: FontWeight.bold)
                       ),
                     ),
                   if (currentPrompt.category.isNotEmpty) const SizedBox(height: 6),
                   Text(
                    currentPrompt.question,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyText1.copyWith(height: 1.4),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: AppColors.primary, size: 30),
              onPressed: _nextPrompt,
              tooltip: '下一個提示',
            ),
          ],
        ),
      ),
    );
  }
}