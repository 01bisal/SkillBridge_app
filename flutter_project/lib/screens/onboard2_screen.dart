import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbridge/utils/user_data_provider.dart';

class Onboard2Screen extends StatefulWidget {
  const Onboard2Screen({super.key});

  @override
  State<Onboard2Screen> createState() => _Onboard2ScreenState();
}

class _Onboard2ScreenState extends State<Onboard2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();
  final _universityController = TextEditingController();
  final _degreeController = TextEditingController();
  final _skillsController = TextEditingController();
  final _industryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ✅ Load existing skills
    final userData = context.read<UserDataProvider>();
    _skillsController.text = userData.skills;
  }

  @override
  void dispose() {
    _bioController.dispose();
    _universityController.dispose();
    _degreeController.dispose();
    _skillsController.dispose();
    _industryController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      // ✅ SAVE SKILLS
      final userData = context.read<UserDataProvider>();
      userData.updateUserData(
        name: userData.name,
        location: userData.location,
        skills: _skillsController.text.trim(),
      );
      print('✅ Onboard2: Saved skills = ${_skillsController.text.trim()}');

      Navigator.pushNamed(context, '/onboard3');
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDarkMode ? Colors.white24 : Colors.black,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.white,
                    ),
                  ),
                  Text(
                    'Step 2 / 3',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white60 : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildFormGroup(
                        label: 'About me *',
                        isRequired: true,
                        isDarkMode: isDarkMode,
                        child: TextFormField(
                          controller: _bioController,
                          maxLines: 4,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Write a short bio...',
                            hintStyle: TextStyle(
                              color: isDarkMode ? Colors.white60 : Colors.grey,
                            ),
                            filled: true,
                            fillColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.orange,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please write a short bio';
                            }
                            if (value.length < 10) {
                              return 'Bio must be at least 10 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFormGroup(
                        label: 'Education *',
                        isRequired: true,
                        isDarkMode: isDarkMode,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _universityController,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: '[University] *',
                                hintStyle: TextStyle(
                                  color: isDarkMode ? Colors.white60 : Colors.grey,
                                ),
                                filled: true,
                                fillColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your university';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _degreeController,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: '[Degree type] *',
                                hintStyle: TextStyle(
                                  color: isDarkMode ? Colors.white60 : Colors.grey,
                                ),
                                filled: true,
                                fillColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your degree';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFormGroup(
                        label: 'Skills *',
                        isRequired: true,
                        isDarkMode: isDarkMode,
                        child: TextFormField(
                          controller: _skillsController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: '[Search Skills] *',
                            hintStyle: TextStyle(
                              color: isDarkMode ? Colors.white60 : Colors.grey,
                            ),
                            filled: true,
                            fillColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.orange,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your skills';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFormGroup(
                        label: 'Industry of Interest *',
                        isRequired: true,
                        isDarkMode: isDarkMode,
                        child: TextFormField(
                          controller: _industryController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Type industry... *',
                            hintStyle: TextStyle(
                              color: isDarkMode ? Colors.white60 : Colors.grey,
                            ),
                            filled: true,
                            fillColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.orange,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your industry';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '* Required fields',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.white60 : Colors.white70,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                                foregroundColor: isDarkMode ? Colors.white : Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _nextStep,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5),
                                foregroundColor: isDarkMode ? Colors.white : Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormGroup({
    required String label,
    required Widget child,
    required bool isDarkMode,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
