import 'package:flutter/material.dart';
import 'package:stormwolf/core/utils/auth_helper.dart';
import 'package:stormwolf/core/utils/body_type_calculator.dart';
import 'package:stormwolf/data/models/user_model.dart';
import 'package:stormwolf/presentation/screens/auth/body_type_guide.dart';
import 'package:stormwolf/presentation/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _wristController = TextEditingController();
  
  BodyType? _selectedBodyType;
  bool _showBodyTypeGuide = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _wristController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    final user = UserModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      weight: double.parse(_weightController.text),
      height: double.parse(_heightController.text),
      bodyType: _selectedBodyType ?? BodyType.ectomorph,
    );

    final authHelper = AuthHelper();
    await authHelper.saveUserRegistration(user.toMap());
    await authHelper.loginUser();

    if (!mounted) return;
    Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (_) => const MainApp()));
  }

  void _calculateBodyType() {
    if (_wristController.text.isEmpty || 
        _heightController.text.isEmpty) return;

    final wrist = double.parse(_wristController.text);
    final height = double.parse(_heightController.text);
    
    setState(() {
      _selectedBodyType = BodyTypeCalculator.calculateBodyType(
        wrist: wrist, 
        height: height,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showBodyTypeGuide) {
      return BodyTypeGuide(
        onBack: () => setState(() => _showBodyTypeGuide = false),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _firstNameController,
                      label: 'First Name',
                      validator: (value) => 
                        value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      validator: (value) => 
                        value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => 
                  value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: true,
                validator: (value) => 
                  value!.length < 6 ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _weightController,
                      label: 'Weight (kg)',
                      keyboardType: TextInputType.number,
                      validator: (value) => 
                        value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: _heightController,
                      label: 'Height (cm)',
                      keyboardType: TextInputType.number,
                      validator: (value) => 
                        value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Body Type',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              if (_selectedBodyType != null)
                Text(
                  _selectedBodyType!.name.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => setState(() => _showBodyTypeGuide = true),
                child: const Text('How to determine my body type?'),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _wristController,
                label: 'Wrist circumference (cm)',
                keyboardType: TextInputType.number,
                onChanged: (_) => _calculateBodyType(),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('REGISTER'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}