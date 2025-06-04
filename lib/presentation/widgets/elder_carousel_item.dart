import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/models/elder_model.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';

class ElderCarouselItem extends StatelessWidget {
  final ElderModel? elder;
  final bool isSelected;
  final bool isAddNewButton;

  const ElderCarouselItem({
    super.key,
    this.elder,
    required this.isSelected,
    this.isAddNewButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final double imageSize = isSelected ? 180.0 : 100.0;
    final double totalItemHeight = imageSize + (isSelected && !isAddNewButton && elder != null ? 40.0 : 10.0); // Height for image + name
    final double totalItemWidth = imageSize + (isSelected ? 20.0 : 10.0); // Width for image + some padding

    return Container(
      width: totalItemWidth,
      height: totalItemHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAddNewButton 
                  ? AppColors.surface // Background for "+" button circle
                  : AppColors.primaryLight.withOpacity(0.4), // Background for elder avatar circle
              border: isAddNewButton 
                  ? Border.all(color: AppColors.primary.withOpacity(0.7), width: 2.0, style: BorderStyle.solid) 
                  : (isSelected ? Border.all(color: AppColors.primary, width: 2.5) : null), // Border for selected elder
              boxShadow: [
                if (!isAddNewButton) // Add shadow for elder items
                  BoxShadow(
                    color: isSelected
                        ? AppColors.primaryDark.withOpacity(0.35) // More defined shadow for selected
                        : AppColors.textSecondary.withOpacity(0.42), // Softer shadow for unselected
                    blurRadius: isSelected ? 40.0 : 20.0,
                    spreadRadius: isSelected ? 0.7 : 0.0,
                    offset: Offset(0, isSelected ? 8.0 : 2.0),
                  ),
                if (isAddNewButton) // Optional: a very subtle shadow for the add button or none
                   BoxShadow(
                    color: AppColors.textSecondary.withOpacity(0.1),
                    blurRadius: 5.0,
                    offset: Offset(0, 2.0),
                  ),
              ],
            ),
            clipBehavior: Clip.antiAlias, // Ensures content (like CircleAvatar) is clipped to circle
            child: isAddNewButton
                ? Center(
                    child: Icon(
                      Icons.add,
                      size: imageSize * 0.5,
                      color: AppColors.primary,
                    ),
                  )
                : CircleAvatar( // Using CircleAvatar for the image/placeholder
                    radius: imageSize / 2,
                    backgroundImage: elder?.profileImageUrl != null && elder!.profileImageUrl!.startsWith('assets/')
                        ? AssetImage(elder!.profileImageUrl!)
                        : (elder?.profileImageUrl != null ? NetworkImage(elder!.profileImageUrl!) : null) as ImageProvider?,
                    backgroundColor: Colors.transparent, // Parent container now handles background color
                    child: (elder?.profileImageUrl == null && elder != null)
                        ? Text(
                            elder!.name.isNotEmpty ? elder!.name[0] : '?',
                            style: AppTextStyles.headline1.copyWith(
                              color: AppColors.primaryDark,
                              fontSize: isSelected ? imageSize * 0.4 : imageSize * 0.35, // Responsive font size
                            ),
                          )
                        : null,
                  ),
          ),
          if (isSelected && !isAddNewButton && elder != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                elder!.name,
                style: AppTextStyles.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                  fontSize: 15, // Slightly adjusted for better fit
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}