import 'package:flutter/material.dart';

class Onboard3Screen extends StatefulWidget {
  const Onboard3Screen({super.key});

  @override
  State<Onboard3Screen> createState() => _Onboard3ScreenState();
}

class _Onboard3ScreenState extends State<Onboard3Screen> {
  final _formKey = GlobalKey<FormState>();
  final _targetRoleController = TextEditingController();

  int selectedGoal = -1;
  final List<String> goals = [
    'Find a mentor',
    'Build new skills',
    'Get a job',
    'Upskill / Advance my career',
    'Build my network',
  ];

  @override
  void dispose() {
    _targetRoleController.dispose();
    super.dispose();
  }

  void _getStarted() {
    if (_formKey.currentState!.validate()) {
      if (selectedGoal == -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a career goal'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
      // ✅ REMOVED isNewUser parameter - UserState already set in signup
      Navigator.pushReplacementNamed(context, '/home');
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
                    'Step 3 / 3',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Career Goals *',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          'What is your primary goal?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode ? Colors.white70 : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(goals.length, (index) {
                        return _buildGoalOption(index, isDarkMode);
                      }),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Your target role',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                          TextFormField(
                            controller: _targetRoleController,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: 'e.g. UX Designer, Developer, Manager...',
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
                                vertical: 18,
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your target role';
                              }
                              return null;
                            },
                          ),
                        ],
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
                                padding: const EdgeInsets.symmetric(vertical: 14),
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
                            child: TextButton(
                              onPressed: _getStarted,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode ? Colors.white : Colors.white,
                                  decoration: TextDecoration.underline,
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

  Widget _buildGoalOption(int index, bool isDarkMode) {
    final isSelected = selectedGoal == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGoal = index;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? const Color(0xFF2D2D44) : Colors.white)
              : (isDarkMode ? const Color(0xFF2D2D44) : const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(4),
          border: isSelected
              ? Border.all(color: Colors.green, width: 2)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                goals[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}