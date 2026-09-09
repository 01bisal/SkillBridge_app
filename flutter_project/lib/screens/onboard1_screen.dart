import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbridge/utils/user_data_provider.dart';

class Onboard1Screen extends StatefulWidget {
  const Onboard1Screen({super.key});

  @override
  State<Onboard1Screen> createState() => _Onboard1ScreenState();
}

class _Onboard1ScreenState extends State<Onboard1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  int selectedOption = -1;

  @override
  void initState() {
    super.initState();
    // ✅ Load existing name from signup
    final userData = context.read<UserDataProvider>();
    _nameController.text = userData.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      if (selectedOption == -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your role'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // ✅ SAVE NAME AND LOCATION from onboarding
      final userData = context.read<UserDataProvider>();
      userData.updateUserData(
        name: _nameController.text.trim(),
        location: _locationController.text.trim(),
        skills: userData.skills,
      );
      print('✅ Onboard1: Saved name = ${_nameController.text.trim()}');
      print('✅ Onboard1: Saved location = ${_locationController.text.trim()}');

      Navigator.pushNamed(context, '/onboard2');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1A1A2E) : const Color(0xFF2B2C6B),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.white,
                    ),
                  ),
                  Text(
                    'Step 1 / 3',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white60 : Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'I am a.... *',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please select your role to continue',
                style: TextStyle(
                  fontSize: 13,
                  color: isDarkMode ? Colors.white60 : Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              _buildOption(
                index: 0,
                title: 'Students / Graduate',
                subtitle: '(looking for guidance)',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 15),
              _buildOption(
                index: 1,
                title: 'Professional',
                subtitle: '(Want to mentor others)',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 25),
              // Full Name - MANDATORY (pre-filled from signup)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name *',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      filled: true,
                      fillColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      errorStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                      ),
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white60 : Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      if (value.length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Location - MANDATORY
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location / Address *',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _locationController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your location',
                      filled: true,
                      fillColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      errorStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                      ),
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white60 : Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? const Color(0xFF2B2C6B) : Colors.white,
                    foregroundColor: isDarkMode ? Colors.white : const Color(0xFF2B2C6B),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : const Color(0xFF2B2C6B),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  '* Required fields',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode ? Colors.white60 : Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required int index,
    required String title,
    required String subtitle,
    required bool isDarkMode,
  }) {
    final isSelected = selectedOption == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = index;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? const Color(0xFF2D2D44) : Colors.white)
              : (isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.green, width: 2)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? Colors.white60 : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
