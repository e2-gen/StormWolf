import 'package:flutter/material.dart';
import 'package:your_app/core/utils/body_type_calculator.dart';
import 'package:your_app/core/constants/app_constants.dart';
import 'package:your_app/presentation/theme/app_theme.dart';

class BodyTypeCard extends StatelessWidget {
  final BodyType bodyType;
  final bool isSelected;
  final VoidCallback onSelect;

  const BodyTypeCard({
    super.key,
    required this.bodyType,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final cardData = _getBodyTypeData(bodyType);

    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primaryColor.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: cardData.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        cardData.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: cardData.color,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    cardData.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildCharacteristics(context, bodyType),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacteristics(BuildContext context, BodyType type) {
    final characteristics = BodyTypeCalculator.getBodyTypeCharacteristics(type);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الخصائص:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        ...characteristics.map((char) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.circle,
                    size: 8,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      char,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  _BodyTypeCardData _getBodyTypeData(BodyType type) {
    switch (type) {
      case BodyType.ectomorph:
        return _BodyTypeCardData(
          title: 'النحيف (Ectomorph)',
          description: 'هيكل عظمي صغير، صعوبة في زيادة الوزن، أيض سريع',
          color: AppColors.primaryColor,
        );
      case BodyType.mesomorph:
        return _BodyTypeCardData(
          title: 'الرياضي (Mesomorph)',
          description: 'هيكل عظمي متوسط، بناء عضلي طبيعي، يكتسب العضلات بسهولة',
          color: Colors.blueAccent,
        );
      case BodyType.endomorph:
        return _BodyTypeCardData(
          title: 'القوي (Endomorph)',
          description: 'هيكل عظمي كبير، يميل لتخزين الدهون، أيض بطيء',
          color: Colors.purpleAccent,
        );
    }
  }
}

class _BodyTypeCardData {
  final String title;
  final String description;
  final Color color;

  _BodyTypeCardData({
    required this.title,
    required this.description,
    required this.color,
  });
}