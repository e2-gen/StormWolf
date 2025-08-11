import 'package:flutter/material.dart';
import 'package:stormwolf/core/utils/body_type_calculator.dart';
import 'package:stormwolf/core/constants/app_constants.dart';
import 'package:stormwolf/presentation/theme/app_theme.dart';

class BodyTypeGuide extends StatelessWidget {
  final VoidCallback onBack;

  const BodyTypeGuide({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: const Text('دليل تحديد نوع الجسم'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBodyTypeCard(
              context,
              BodyType.ectomorph,
              'النحيف (Ectomorph)',
              'هيكل عظمي صغير - صعوبة في زيادة الوزن - أيض سريع',
              AppColors.primaryColor,
            ),
            const SizedBox(height: 16),
            _buildBodyTypeCard(
              context,
              BodyType.mesomorph,
              'الرياضي (Mesomorph)',
              'هيكل عظمي متوسط - بناء عضلي طبيعي - يكتسب العضلات والدهون بسهولة متوسطة',
              Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            _buildBodyTypeCard(
              context,
              BodyType.endomorph,
              'القوي (Endomorph)',
              'هيكل عظمي كبير - يميل لتخزين الدهون - أيض بطيء',
              Colors.purpleAccent,
            ),
            const SizedBox(height: 32),
            _buildMeasurementGuide(context),
            const SizedBox(height: 32),
            _buildWristMeasurementCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyTypeCard(
    BuildContext context,
    BodyType type,
    String title,
    String description,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.darkSurface,
      child: Padding(
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
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'نصائح التمرين:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            ...BodyTypeCalculator.getWorkoutRecommendations(type)
                .map((tip) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(child: Text(tip)),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementGuide(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'كيفية تحديد نوع جسمك:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        _buildStepItem(context, '1', 'قم بقياس محيط معصمك باستخدام شريط قياس'),
        _buildStepItem(
            context, '2', 'أدخل القياس (بالسنتيمتر) في الحقل المخصص'),
        _buildStepItem(context, '3', 'أدخل طولك (بالسنتيمتر)'),
        _buildStepItem(
            context, '4', 'سيتم حساب نوع جسمك تلقائياً بناء على هذه القياسات'),
      ],
    );
  }

  Widget _buildStepItem(BuildContext context, String step, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWristMeasurementCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.darkSurface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'كيف تقيس معصمك بشكل صحيح:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildMeasurementTip(
                '1. استخدم شريط قياس مرن (مثل تلك المستخدمة في الخياطة)'),
            _buildMeasurementTip(
                '2. قم بلف الشريط حول أضيق جزء من معصمك'),
            _buildMeasurementTip(
                '3. تأكد من أن الشريط ليس فضفاضاً ولا ضيقاً جداً'),
            _buildMeasurementTip('4. سجل القياس بالسنتيمتر'),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/images/wrist_measurement.png',
                width: 200,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementTip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 16, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}