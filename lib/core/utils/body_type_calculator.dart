import 'dart:math';

// أنواع الجسم الأساسية
enum BodyType {
  ectomorph,  // النحيف صعب زيادة العضلات
  mesomorph,  // الرياضي الطبيعي
  endomorph   // القابل لزيادة الدهون بسهولة
}

class BodyTypeCalculator {
  /// حساب نوع الجسم بناء على قياسات المعصم والطول
  static BodyType calculateByWristHeight({
    required double wristCircumference, // محيط المعصم (سم)
    required double height,             // الطول (سم)
  }) {
    // حساب مؤشر حجم الهيكل العظمي
    final frameSize = height / wristCircumference;

    if (frameSize > 10.5) {
      return BodyType.ectomorph;
    } else if (frameSize > 9.6) {
      return BodyType.mesomorph;
    } else {
      return BodyType.endomorph;
    }
  }

  /// حساب نوع الجسم باستخدام معادلة أكثر دقة (الوزن + الطول + محيط المعصم)
  static BodyType calculateAdvanced({
    required double weight,    // الوزن (كجم)
    required double height,    // الطول (سم)
    required double wrist,     // محيط المعصم (سم)
    required double ankle,     // محيط الكاحل (سم) - اختياري
  }) {
    // مؤشر حجم الهيكل العظمي المعدل
    final adjustedFrameSize = (height / wrist) + (height / (ankle ?? wrist)) / 2;

    // نسبة الوزن إلى الطول
    final weightHeightRatio = weight / pow(height / 100, 2);

    if (adjustedFrameSize > 10.4 && weightHeightRatio < 22) {
      return BodyType.ectomorph;
    } else if (adjustedFrameSize > 9.5 && adjustedFrameSize <= 10.4) {
      return BodyType.mesomorph;
    } else {
      return BodyType.endomorph;
    }
  }

  /// حساب السعرات الحرارية اليومية الموصى بها حسب نوع الجسم
  static double calculateDailyCalories({
    required BodyType bodyType,
    required double weight,
    required double height,
    required int age,
    required String gender,
    required double activityLevel, // 1.2-2.5
  }) {
    double bmr;

    // حساب معدل الأيض الأساسي (BMR)
    if (gender.toLowerCase() == 'male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    // تعديل حسب نوع الجسم
    switch (bodyType) {
      case BodyType.ectomorph:
        return bmr * activityLevel * 1.1; // زيادة 10% لصعوبة زيادة الوزن
      case BodyType.mesomorph:
        return bmr * activityLevel;
      case BodyType.endomorph:
        return bmr * activityLevel * 0.9; // تقليل 10% لسهولة زيادة الوزن
    }
  }

  /// حساب البروتين اليومي الموصى به (جرام/كجم من وزن الجسم)
  static double calculateProteinIntake(BodyType bodyType, double weight) {
    switch (bodyType) {
      case BodyType.ectomorph:
        return 2.2 * weight; // يحتاجون بروتين أكثر لبناء العضلات
      case BodyType.mesomorph:
        return 1.8 * weight;
      case BodyType.endomorph:
        return 2.0 * weight; // بروتين عالي للمحافظة على العضلات أثناء التنحيف
    }
  }

  /// توصيات التمرين حسب نوع الجسم
  static List<String> getWorkoutRecommendations(BodyType bodyType) {
    switch (bodyType) {
      case BodyType.ectomorph:
        return [
          'تمارين مركبة بوزن ثقيل',
          '3-4 جلسات أسبوعياً',
          'راحة طويلة بين المجموعات (2-3 دقائق)',
          'تقليل التمارين الهوائية',
          'زيادة السعرات الحرارية'
        ];
      case BodyType.mesomorph:
        return [
          'مزيج من التمارين المركبة والعزل',
          '4-5 جلسات أسبوعياً',
          'راحة متوسطة بين المجموعات (1-2 دقيقة)',
          'تمارين هوائية معتدلة',
          'الحفاظ على توازن السعرات'
        ];
      case BodyType.endomorph:
        return [
          'تمارين عالية الكثافة',
          '5-6 جلسات أسبوعياً',
          'راحة قصيرة بين المجموعات (30-60 ثانية)',
          'تمارين هوائية مكثفة',
          'نظام غذائي منخفض الكربوهيدرات'
        ];
    }
  }
}

// نموذج بيانات نتيجة حساب نوع الجسم
class BodyTypeResult {
  final BodyType bodyType;
  final String description;
  final String imagePath; // يمكن استخدام أيقونة من flutter بدلاً من صورة
  final List<String> characteristics;
  final List<String> workoutTips;
  final List<String> nutritionTips;

  BodyTypeResult({
    required this.bodyType,
    required this.description,
    required this.imagePath,
    required this.characteristics,
    required this.workoutTips,
    required this.nutritionTips,
  });

  factory BodyTypeResult.fromType(BodyType type) {
    switch (type) {
      case BodyType.ectomorph:
        return BodyTypeResult(
          bodyType: type,
          description: 'جسم نحيف مع صعوبة في بناء العضلات وزيادة الوزن',
          imagePath: 'assets/ecto.png',
          characteristics: [
            'هيكل عظمي صغير',
            'عضلات طويلة ونحيفة',
            'معدل أيض سريع',
            'صعوبة في زيادة الوزن'
          ],
          workoutTips: [
            'ركز على التمارين المركبة الثقيلة',
            'قلل التمارين الهوائية',
            'استخدم فترات راحة أطول'
          ],
          nutritionTips: [
            'استهلك سعرات حرارية عالية',
            'تناول 5-6 وجبات يومياً',
            'ركز على الكربوهيدرات المعقدة'
          ],
        );
      case BodyType.mesomorph:
        return BodyTypeResult(
          bodyType: type,
          description: 'جسم رياضي طبيعي مع قابلية جيدة لبناء العضلات',
          imagePath: 'assets/meso.png',
          characteristics: [
            'هيكل عظمي متوسط',
            'عضلات واضحة بشكل طبيعي',
            'توزيع جيد للدهون',
            'يكتسب العضلات والدهون بسهولة متوسطة'
          ],
          workoutTips: [
            'موازنة بين التمارين المركبة والعزل',
            'تنويع الروتين التدريبي',
            'حافظ على شدة متوسطة إلى عالية'
          ],
          nutritionTips: [
            'حافظ على توازن المغذيات',
            'بروتين كافي لصيانة العضلات',
            'تحكم في كمية الكربوهيدرات حسب الهدف'
          ],
        );
      case BodyType.endomorph:
        return BodyTypeResult(
          bodyType: type,
          description: 'جسم يميل إلى تخزين الدهون مع صعوبة في فقدانها',
          imagePath: 'assets/endo.png',
          characteristics: [
            'هيكل عظمي كبير',
            'معدل أيض بطيء',
            'يكتسب الدهون بسهولة',
            'عضلات قوية لكنها مغطاة بطبقة دهنية'
          ],
          workoutTips: [
            'ركز على تمارين HIIT',
            'زيد من النشاط اليومي العام',
            'قلل فترات الراحة بين المجموعات'
          ],
          nutritionTips: [
            'تحكم في السعرات الحرارية',
            'قلل الكربوهيدرات البسيطة',
            'زد الألياف والبروتين'
          ],
        );
    }
  }
}