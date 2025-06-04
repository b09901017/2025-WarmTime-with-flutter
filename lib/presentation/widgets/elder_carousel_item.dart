import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/models/elder_model.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';

class ElderCarouselItem extends StatelessWidget {
  final ElderModel? elder; // Nullable for the "+" button case
  final bool isSelected;
  final bool isAddNewButton; // To differentiate the "+" button

  const ElderCarouselItem({
    super.key,
    this.elder,
    required this.isSelected,
    this.isAddNewButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final double imageSize = isSelected ? 120.0 : 80.0;
    final double elevation = isSelected ? 8.0 : 2.0;

    Widget content;

    if (isAddNewButton) {
      content = Center(
        child: Icon(
          Icons.add,
          size: imageSize * 0.5,
          color: AppColors.primary,
        ),
      );
    } else if (elder != null) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: imageSize / 2,
            backgroundImage: elder!.profileImageUrl != null && elder!.profileImageUrl!.startsWith('assets/')
                ? AssetImage(elder!.profileImageUrl!)
                : (elder!.profileImageUrl != null ? NetworkImage(elder!.profileImageUrl!) : null) as ImageProvider?,
            backgroundColor: AppColors.primaryLight.withOpacity(0.5),
            child: elder!.profileImageUrl == null
                ? Text(
                    elder!.name.isNotEmpty ? elder!.name[0] : '?',
                    style: AppTextStyles.headline1.copyWith(
                      color: AppColors.primaryDark,
                      fontSize: isSelected ? 40 : 28,
                    ),
                  )
                : null,
          ),
          if (isSelected) // Only show name for selected elder
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                elder!.name,
                style: AppTextStyles.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      );
    } else {
      content = const SizedBox.shrink(); // Should not happen if not add button and elder is null
    }


    return Material(
      elevation: elevation,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: isAddNewButton ? AppColors.surface : Colors.transparent, // Background for add button
      child: Container(
        width: imageSize + (isSelected ? 20 : 10), // Add padding for name visibility
        height: imageSize + (isSelected ? 40 : 10), // Add padding for name visibility
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isAddNewButton ? Border.all(color: AppColors.primary, width: 2.0, style: BorderStyle.solid) : null,
        ),
        child: content,
      ),
    );
  }
}