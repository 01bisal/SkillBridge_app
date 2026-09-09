import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbridge/utils/user_state.dart';
import 'package:skillbridge/utils/user_data_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Password strength
  double _passwordStrength = 0.0;
  String _passwordStrengthText = '';
  Color _passwordStrengthColor = Colors.grey;

  void _checkPasswordStrength(String value) {
    setState(() {
      if (value.isEmpty) {
        _passwordStrength = 0.0;
        _passwordStrengthText = '';
        _passwordStrengthColor = Colors.grey;
        return;
      }

      double strength = 0.0;
      String text = '';
      Color color = Colors.red;

      if (value.length >= 6) strength += 0.25;
      if (value.length >= 10) strength += 0.15;
      if (value.contains(RegExp(r'[A-Z]'))) strength += 0.2;
      if (value.contains(RegExp(r'[a-z]'))) strength += 0.2;
      if (value.contains(RegExp(r'[0-9]'))) strength += 0.1;
      if (value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) strength += 0.1;

      if (strength > 1.0) strength = 1.0;

      if (strength < 0.4) {
        text = 'Weak';
        color = Colors.red;
      } else if (strength < 0.7) {
        text = 'Medium';
        color = Colors.orange;
      } else {
        text = 'Strong';
        color = Colors.green;
      }

      _passwordStrength = strength;
      _passwordStrengthText = text;
      _passwordStrengthColor = color;
    });
  }

  String? _passwordMatchError;

  void _checkPasswordMatch(String value) {
    setState(() {
      if (value.isEmpty) {
        _passwordMatchError = null;
        return;
      }
      if (value != _passwordController.text) {
        _passwordMatchError = 'Passwords do not match';
      } else {
        _passwordMatchError = null;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // ✅ SAVE NAME from signup to UserDataProvider
      final userDataProvider = context.read<UserDataProvider>();
      userDataProvider.updateUserData(
        name: _nameController.text.trim(),
        location: 'Your Location', // Default - will be updated in onboard1
        skills: 'Your Skills',      // Default - will be updated in onboard2
      );

      context.read<UserState>().setUserType(true);
      print('✅ Signup: Saved name = ${_nameController.text.trim()}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Account created successfully!'),
            ],
          ),
          backgroundColor: Color(0xFF2B2C6B),
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/onboard1');
      }
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 10),
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: isDarkMode ? Colors.white : Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Join SkillBridge and start your journey',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDarkMode ? Colors.white60 : Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF2D2D44) : Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildInputField(
                          label: 'Full Name *',
                          controller: _nameController,
                          hintText: 'Enter your full name',
                          prefixIcon: Icons.person_outline,
                          isDarkMode: isDarkMode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            if (value.length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        _buildInputField(
                          label: 'Email Address *',
                          controller: _emailController,
                          hintText: 'Enter your email',
                          prefixIcon: Icons.email_outlined,
                          isDarkMode: isDarkMode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputField(
                              label: 'Password *',
                              controller: _passwordController,
                              hintText: 'Create a strong password',
                              prefixIcon: Icons.lock_outline,
                              obscure: _obscurePassword,
                              isDarkMode: isDarkMode,
                              onToggleObscure: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              onChanged: _checkPasswordStrength,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                if (_passwordStrength < 0.4) {
                                  return 'Password is too weak';
                                }
                                return null;
                              },
                            ),
                            if (_passwordController.text.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: _passwordStrength,
                                          backgroundColor: Colors.grey[200],
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            _passwordStrengthColor,
                                          ),
                                          minHeight: 4,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _passwordStrengthText,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _passwordStrengthColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputField(
                              label: 'Confirm Password *',
                              controller: _confirmPasswordController,
                              hintText: 'Re-enter your password',
                              prefixIcon: Icons.lock_outline,
                              obscure: _obscureConfirmPassword,
                              isDarkMode: isDarkMode,
                              onToggleObscure: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                              onChanged: _checkPasswordMatch,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            if (_confirmPasswordController.text.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    Icon(
                                      _confirmPasswordController.text == _passwordController.text
                                          ? Icons.check_circle
                                          : Icons.error_outline,
                                      size: 14,
                                      color: _confirmPasswordController.text == _passwordController.text
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _confirmPasswordController.text == _passwordController.text
                                          ? 'Passwords match ✓'
                                          : 'Passwords do not match',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _confirmPasswordController.text == _passwordController.text
                                            ? Colors.green[600]
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (_passwordMatchError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  _passwordMatchError!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2B2C6B),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              disabledBackgroundColor: Colors.grey[400],
                            ),
                            child: _isLoading
                                ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Creating Account...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                                : const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white60 : Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
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
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required bool isDarkMode,
    String? Function(String?)? validator,
    String? hintText,
    IconData? prefixIcon,
    bool obscure = false,
    VoidCallback? onToggleObscure,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 15,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white60 : Colors.grey[400],
            ),
            filled: true,
            fillColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.grey[50],
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: isDarkMode ? Colors.white60 : Colors.grey[500], size: 20)
                : null,
            suffixIcon: (label.contains('Password') && !label.contains('Confirm'))
                ? IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                size: 18,
                color: isDarkMode ? Colors.white60 : Colors.grey,
              ),
              onPressed: onToggleObscure,
            )
                : (label.contains('Confirm Password')
                ? IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                size: 18,
                color: isDarkMode ? Colors.white60 : Colors.grey,
              ),
              onPressed: onToggleObscure,
            )
                : null),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            errorStyle: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
