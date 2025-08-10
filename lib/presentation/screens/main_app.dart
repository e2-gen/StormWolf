import 'package:flutter/material.dart';
import 'package:your_app/data/models/user_model.dart';
import 'package:your_app/presentation/screens/workout_screen.dart';
import 'package:your_app/presentation/screens/profile_screen.dart';
import 'package:your_app/presentation/screens/progress_screen.dart';
import 'package:your_app/presentation/screens/nutrition_screen.dart';
import 'package:your_app/presentation/theme/app_theme.dart';
import 'package:your_app/core/utils/auth_helper.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  late UserModel _currentUser;

  final List<Widget> _screens = [
    const WorkoutScreen(),
    const ProgressScreen(),
    const NutritionScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authHelper = AuthHelper();
    final userData = await authHelper.getUserData();
    if (userData != null) {
      setState(() {
        _currentUser = UserModel.fromMap(userData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildFuturisticNavBar(),
      floatingActionButton: _currentIndex == 0 ? _buildWorkoutFab() : null,
    );
  }

  Widget _buildFuturisticNavBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColors.darkSurface,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textSecondary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center, size: 28),
            activeIcon: Icon(Icons.fitness_center, 
              size: 32, 
              color: AppColors.primaryColor),
            label: 'التمارين',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart, size: 28),
            activeIcon: Icon(Icons.show_chart, 
              size: 32, 
              color: AppColors.primaryColor),
            label: 'التقدم',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant, size: 28),
            activeIcon: Icon(Icons.restaurant, 
              size: 32, 
              color: AppColors.primaryColor),
            label: 'التغذية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            activeIcon: Icon(Icons.person, 
              size: 32, 
              color: AppColors.primaryColor),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutFab() {
    return FloatingActionButton(
      onPressed: () {
        // بدء تمرين جديد
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StartWorkoutScreen(user: _currentUser),
          ),
        );
      },
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.add, size: 32),
    );
  }
}

/// شاشة بدء التمرين الجديد
class StartWorkoutScreen extends StatelessWidget {
  final UserModel user;

  const StartWorkoutScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('بدء تمرين جديد'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'مرحباً ${user.firstName}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 32),
            _buildWorkoutOption(
              context,
              'تمرين مخصص',
              Icons.build,
              Colors.blueAccent,
              () => _startCustomWorkout(context),
            ),
            const SizedBox(height: 16),
            _buildWorkoutOption(
              context,
              'برنامج ${user.bodyType.name}',
              Icons.fitness_center,
              AppColors.primaryColor,
              () => _startBodyTypeWorkout(context, user.bodyType),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutOption(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_left, color: color),
          ],
        ),
      ),
    );
  }

  void _startCustomWorkout(BuildContext context) {
    // الانتقال لشاشة التمرين المخصص
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomWorkoutScreen(),
      ),
    );
  }

  void _startBodyTypeWorkout(BuildContext context, BodyType bodyType) {
    // الانتقال لشاشة التمرين حسب نوع الجسم
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BodyTypeWorkoutScreen(bodyType: bodyType),
      ),
    );
  }
}