import 'package:flutter/material.dart';
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '10:15',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.signal_cellular_alt, size: 14),
                          SizedBox(width: 5),
                          Icon(Icons.wifi, size: 14),
                          SizedBox(width: 5),
                          Icon(Icons.battery_full, size: 14),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => _showLogoutDialog(context),
                            icon: const Icon(
                              Icons.logout,
                              color: Color(0xFF2B2C6B),
                              size: 24,
                            ),
                            tooltip: 'Logout',
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/settings');
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Color(0xFF2B2C6B),
                              size: 24,
                            ),
                            tooltip: 'Settings',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // Profile Card
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2B2C6B),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              userData.name.isNotEmpty
                                  ? userData.name[0].toUpperCase()
                                  : 'U',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          userData.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userData.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Stats
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('12', 'Mentorships', context),
                        _buildDivider(context),
                        _buildStatItem('8', 'Sessions', context),
                        _buildDivider(context),
                        _buildStatItem('6', 'Skills', context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Menu Items
                  _buildMenuItem(
                    icon: Icons.edit,
                    label: 'Edit Profile',
                    onTap: () {
                      Navigator.pushNamed(context, '/edit_profile');
                    },
                    context: context,
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Notifications feature coming soon!'),
                          backgroundColor: Color(0xFF2B2C6B),
                        ),
                      );
                    },
                    context: context,
                  ),
                  _buildMenuItem(
                    icon: Icons.lock,
                    label: 'Privacy & Security',
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    icon: Icons.logout,
                    label: 'Logout',
                    isLogout: true,
                    onTap: () => _showLogoutDialog(context),
                    context: context,
                  ),
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
                  color: Theme.of(context).cardColor,
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
                      context: context,
                    ),
                    _buildNavItem(
                      icon: Icons.explore,
                      label: 'Discovery',
                      isActive: false,
                      onTap: () => Navigator.pushReplacementNamed(context, '/discovery'),
                      context: context,
                    ),
                    _buildNavItem(
                      icon: Icons.chat,
                      label: 'Messages',
                      isActive: false,
                      onTap: () => Navigator.pushReplacementNamed(context, '/messages'),
                      context: context,
                    ),
                    _buildNavItem(
                      icon: Icons.calendar_today,
                      label: 'Sessions',
                      isActive: false,
                      onTap: () => Navigator.pushReplacementNamed(context, '/sessions'),
                      context: context,
                    ),
                    _buildNavItem(
                      icon: Icons.person,
                      label: 'Profile',
                      isActive: true,
                      onTap: () {},
                      context: context,
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

  Widget _buildStatItem(String number, String label, BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: Theme.of(context).dividerColor.withOpacity(0.3),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required BuildContext context,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isLogout ? Colors.red : const Color(0xFF2B2C6B),
                ),
                const SizedBox(width: 15),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isLogout
                        ? Colors.red
                        : Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              size: 18,
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
    required BuildContext context,
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