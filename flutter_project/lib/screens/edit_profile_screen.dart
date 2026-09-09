import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:skillbridge/utils/user_data_provider.dart';
import 'package:skillbridge/utils/image_picker_helper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _skillsController = TextEditingController();
  String? _selectedImagePath;
  Uint8List? _selectedImageBytes; // ✅ NEW: Store bytes for web

  @override
  void initState() {
    super.initState();
    final userData = context.read<UserDataProvider>();
    _nameController.text = userData.name;
    _locationController.text = userData.location;
    _skillsController.text = userData.skills;
    _selectedImagePath = userData.profileImagePath;
    _selectedImageBytes = userData.profileImageBytes; // ✅ Load existing bytes
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final result = await ImagePickerHelper.showImagePickerDialog(context);
    if (result != null) {
      if (kIsWeb) {
        // ✅ For web: store bytes
        setState(() {
          _selectedImageBytes = result as Uint8List;
          _selectedImagePath = 'web_image';
        });
        print('✅ Web image selected: ${_selectedImageBytes?.length} bytes');
      } else {
        // ✅ For mobile/desktop: store file path
        setState(() {
          _selectedImagePath = result as String;
          _selectedImageBytes = null;
        });
        print('✅ Mobile image selected: $_selectedImagePath');
      }
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final userData = context.read<UserDataProvider>();

      // ✅ Save both path and bytes
      userData.updateUserData(
        name: _nameController.text.trim(),
        location: _locationController.text.trim(),
        skills: _skillsController.text.trim(),
        profileImagePath: _selectedImagePath,
        profileImageBytes: _selectedImageBytes, // ✅ Save bytes
      );

      print('✅ Saved: Name=${_nameController.text.trim()}, ImagePath=$_selectedImagePath, ImageBytes=${_selectedImageBytes?.length}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Profile updated successfully!'),
            ],
          ),
          backgroundColor: Color(0xFF2B2C6B),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF2B2C6B),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ✅ Profile Picture with Upload Option
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: isDarkMode
                              ? [Colors.grey[800]!, Colors.grey[600]!]
                              : [const Color(0xFF2B2C6B), const Color(0xFF4A4A8A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2B2C6B).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: _buildProfileImage(),
                      ),
                    ),
                    // Camera icon overlay
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2B2C6B),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _pickImage,
                child: const Text(
                  'Change Profile Picture',
                  style: TextStyle(
                    color: Color(0xFF2B2C6B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name Field
              _buildTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: _nameController,
                icon: Icons.person_outline,
                isDarkMode: isDarkMode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Location Field
              _buildTextField(
                label: 'Location',
                hint: 'Enter your location',
                controller: _locationController,
                icon: Icons.location_on_outlined,
                isDarkMode: isDarkMode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Skills Field
              _buildTextField(
                label: 'Skills',
                hint: 'Enter your skills (comma separated)',
                controller: _skillsController,
                icon: Icons.stars_outlined,
                isDarkMode: isDarkMode,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your skills';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B2C6B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
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
    );
  }

  // ✅ Web-compatible profile image builder (shows preview in Edit Profile)
  Widget _buildProfileImage() {
    final hasImage = _selectedImagePath != null && _selectedImagePath!.isNotEmpty;

    // ✅ If no image selected, show initials
    if (!hasImage) {
      return Container(
        width: 120,
        height: 120,
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1A1A2E)
            : Colors.white,
        child: Center(
          child: Text(
            _nameController.text.isNotEmpty
                ? _nameController.text[0].toUpperCase()
                : 'U',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : const Color(0xFF2B2C6B),
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // ✅ For web: use Image.memory if bytes are available
    if (kIsWeb && _selectedImageBytes != null) {
      return Image.memory(
        _selectedImageBytes!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error displaying web image: $error');
          return Container(
            width: 120,
            height: 120,
            color: Colors.grey[300],
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          );
        },
      );
    }

    // ✅ For mobile/desktop: use Image.file
    if (!kIsWeb && _selectedImagePath != null && _selectedImagePath != 'web_image') {
      return Image.file(
        File(_selectedImagePath!),
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error displaying file image: $error');
          return Container(
            width: 120,
            height: 120,
            color: Colors.grey[300],
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          );
        },
      );
    }

    // Fallback
    return Container(
      width: 120,
      height: 120,
      color: Colors.grey[300],
      child: const Icon(
        Icons.person,
        size: 50,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required bool isDarkMode,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDarkMode ? Colors.white60 : Colors.grey[400],
            ),
            prefixIcon: Icon(icon, color: const Color(0xFF2B2C6B)),
            filled: true,
            fillColor: isDarkMode ? const Color(0xFF2D2D44) : Colors.grey[50],
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
