import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:skillbridge/utils/dialog_utils.dart';
import 'package:skillbridge/utils/user_data_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) async {
    final confirm = await DialogUtils.showStyledLogoutDialog(context);
    if (confirm == true && context.mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserDataProvider>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final hasImage = userData.profileImagePath.isNotEmpty || userData.profileImageBytes != null;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Photo
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDarkMode
                            ? [Colors.grey[800]!, Colors.grey[600]!]
                            : [const Color(0xFF2B2C6B), const Color(0xFF4A4A8A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -50,
                          right: -50,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          left: -30,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/settings');
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile Picture
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/edit_profile');
                          },
                          child: Transform.translate(
                            offset: const Offset(0, -50),
                            child: Container(
                              width: 110,
                              height: 110,
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
                              child: Container(
                                width: 104,
                                height: 104,
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                                ),
                                child: ClipOval(
                                  // ✅ Pass context to _buildProfileImage
                                  child: _buildProfileImage(context, userData),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Transform.translate(
                          offset: const Offset(0, -20),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Follow feature coming soon!'),
                                  backgroundColor: Color(0xFF2B2C6B),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2B2C6B),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text(
                              'Follow',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // User Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: isDarkMode ? Colors.white60 : Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              userData.location,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode ? Colors.white60 : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDarkMode ? const Color(0xFF2D2D44) : Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Passionate about learning and growing in tech. '
                                'Always looking for new opportunities to mentor and be mentored. 🚀',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Stats Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('12', 'Mentorships', isDarkMode),
                          _buildDivider(),
                          _buildStatItem('8', 'Sessions', isDarkMode),
                          _buildDivider(),
                          _buildStatItem('6', 'Skills', isDarkMode),
                          _buildDivider(),
                          _buildStatItem('4.8', 'Rating', isDarkMode),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Menu Items
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          icon: Icons.edit,
                          label: 'Edit Profile',
                          subtitle: 'Update your personal information',
                          onTap: () {
                            Navigator.pushNamed(context, '/edit_profile');
                          },
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                        ),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          icon: Icons.person_add,
                          label: 'Find Mentors',
                          subtitle: 'Discover mentors in your field',
                          onTap: () {
                            Navigator.pushNamed(context, '/discovery');
                          },
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                        ),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          icon: Icons.notifications,
                          label: 'Notifications',
                          subtitle: 'Stay updated with your network',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Notifications feature coming soon!'),
                                backgroundColor: Color(0xFF2B2C6B),
                              ),
                            );
                          },
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                        ),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          icon: Icons.lock,
                          label: 'Privacy & Security',
                          subtitle: 'Manage your account security',
                          onTap: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                        ),
                        const SizedBox(height: 16),
                        _buildMenuItem(
                          icon: Icons.logout,
                          label: 'Logout',
                          subtitle: 'Sign out of your account',
                          isLogout: true,
                          onTap: () => _showLogoutDialog(context),
                          isDarkMode: isDarkMode,
                          cardColor: cardColor,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),

            // Bottom Navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.home,
                      label: 'Home',
                      isActive: false,
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                            (route) => false,
                      ),
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.explore,
                      label: 'Discovery',
                      isActive: false,
                      onTap: () => Navigator.pushReplacementNamed(context, '/discovery'),
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.chat,
                      label: 'Messages',
                      isActive: false,
                      onTap: () => Navigator.pushReplacementNamed(context, '/messages'),
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.calendar_today,
                      label: 'Sessions',
                      isActive: false,
                      onTap: () => Navigator.pushReplacementNamed(context, '/sessions'),
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.person,
                      label: 'Profile',
                      isActive: true,
                      onTap: () {},
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ SHOW IMAGE in Profile (Web Compatible) - NOW WITH CONTEXT PARAMETER
  Widget _buildProfileImage(BuildContext context, UserDataProvider userData) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final hasImage = userData.profileImagePath.isNotEmpty || userData.profileImageBytes != null;

    // ✅ If no image, show initials
    if (!hasImage) {
      return Container(
        width: 104,
        height: 104,
        color: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
        child: Center(
          child: Text(
            userData.name.isNotEmpty
                ? userData.name[0].toUpperCase()
                : 'U',
            style: TextStyle(
              color: isDarkMode ? Colors.white : const Color(0xFF2B2C6B),
              fontSize: 44,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // ✅ For web: use Image.memory if bytes are available
    if (kIsWeb && userData.profileImageBytes != null) {
      print('✅ Profile: Displaying web image (${userData.profileImageBytes?.length} bytes)');
      return Image.memory(
        userData.profileImageBytes!,
        width: 104,
        height: 104,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error displaying profile image: $error');
          return Container(
            width: 104,
            height: 104,
            color: Colors.grey[300],
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          );
        },
      );
    }

    // ✅ For mobile/desktop: use Image.file
    if (!kIsWeb && userData.profileImagePath.isNotEmpty) {
      return Image.file(
        File(userData.profileImagePath),
        width: 104,
        height: 104,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error displaying file image: $error');
          return Container(
            width: 104,
            height: 104,
            color: Colors.grey[300],
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          );
        },
      );
    }

    // Fallback
    return Container(
      width: 104,
      height: 104,
      color: Colors.grey[300],
      child: const Icon(Icons.person, size: 50, color: Colors.grey),
    );
  }

  Widget _buildStatItem(String number, String label, bool isDarkMode) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? Colors.white60 : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDarkMode,
    required Color cardColor,
    bool isLogout = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isLogout
                    ? Colors.red.withOpacity(0.1)
                    : const Color(0xFF2B2C6B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isLogout ? Colors.red : const Color(0xFF2B2C6B),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isLogout
                          ? Colors.red
                          : (isDarkMode ? Colors.white : Colors.black87),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? Colors.white60 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: isLogout ? Colors.red.withOpacity(0.5) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? const Color(0xFF2B2C6B) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? const Color(0xFF2B2C6B) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
