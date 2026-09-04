import 'package:flutter/material.dart';

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
      Navigator.pushNamed(context, '/onboard3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xFF2B2C6B),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          children: [
            // Header with line
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Step 2 / 3',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Scrollable Form Content
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildFormGroup(
                        label: 'About me *',
                        isRequired: true,
                        child: TextFormField(
                          controller: _bioController,
                          maxLines: 4,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Write a short bio...',
                            filled: true,
                            fillColor: const Color(0xFFE5E5E5),
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
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _universityController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: '[University] *',
                                filled: true,
                                fillColor: const Color(0xFFE5E5E5),
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
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: '[Degree type] *',
                                filled: true,
                                fillColor: const Color(0xFFE5E5E5),
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
                        child: TextFormField(
                          controller: _skillsController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: '[Search Skills] *',
                            filled: true,
                            fillColor: const Color(0xFFE5E5E5),
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
                        child: TextFormField(
                          controller: _industryController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Type industry... *',
                            filled: true,
                            fillColor: const Color(0xFFE5E5E5),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '* Required fields',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE5E5E5),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _nextStep,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE5E5E5),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'NEXT',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
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
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
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