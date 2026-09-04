import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbridge/utils/dialog_utils.dart';
import 'package:skillbridge/utils/user_state.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  void _showLogoutDialog(BuildContext context) async {
    final confirm = await DialogUtils.showStyledLogoutDialog(context);
    if (confirm == true && context.mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isNewUser = context.watch<UserState>().isNewUser;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                      Text(
                        '10:15',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.signal_cellular_alt,
                              size: 14, color: isDarkMode ? Colors.white70 : Colors.black87),
                          const SizedBox(width: 5),
                          Icon(Icons.wifi,
                              size: 14, color: isDarkMode ? Colors.white70 : Colors.black87),
                          const SizedBox(width: 5),
                          Icon(Icons.battery_full,
                              size: 14, color: isDarkMode ? Colors.white70 : Colors.black87),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Header with Logout Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Messages',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showLogoutDialog(context),
                        icon: Icon(
                          Icons.logout,
                          color: isDarkMode ? Colors.white70 : const Color(0xFF2B2C6B),
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Conditional: Show Empty State for New Users
                  if (isNewUser)
                    _buildEmptyState(
                      icon: Icons.chat_outlined,
                      title: 'No Messages Yet',
                      subtitle: 'Start connecting with mentors and begin your journey!',
                      buttonText: 'Find a Mentor',
                      onPressed: () => Navigator.pushReplacementNamed(context, '/discovery'),
                      isDarkMode: isDarkMode,
                    )
                  else
                    Column(
                      children: [
                        _buildChatItem(
                          initial: 'J',
                          name: 'Jane Doe',
                          message: 'Great! Let\'s catch up at 3pm tomorrow.',
                          time: '11:20',
                          isUnread: true,
                          isDarkMode: isDarkMode,
                          context: context, // ✅ Pass context
                        ),
                        _buildChatItem(
                          initial: 'M',
                          name: 'Michael Chen',
                          message: 'I shared the React video I mentioned.',
                          time: '10:05',
                          isUnread: false,
                          isDarkMode: isDarkMode,
                          context: context, // ✅ Pass context
                        ),
                        _buildChatItem(
                          initial: 'S',
                          name: 'Sarah Williams',
                          message: 'Check out the resume template I sent.',
                          time: 'Yesterday',
                          isUnread: true,
                          isDarkMode: isDarkMode,
                          context: context, // ✅ Pass context
                        ),
                        _buildChatItem(
                          initial: 'K',
                          name: 'Kim (Mentor)',
                          message: 'Session confirmed for tomorrow.',
                          time: 'Yesterday',
                          isUnread: false,
                          isDarkMode: isDarkMode,
                          context: context, // ✅ Pass context
                        ),
                      ],
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
                      isActive: true,
                      onTap: () {},
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
                      isActive: false,
                      onTap: () => Navigator.pushReplacementNamed(context, '/profile'),
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

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
    required bool isDarkMode,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF2B2C6B).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 50,
                color: const Color(0xFF2B2C6B),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white60 : Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B2C6B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem({
    required String initial,
    required String name,
    required String message,
    required String time,
    required bool isUnread,
    required bool isDarkMode,
    required BuildContext context, // ✅ ADD THIS
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // ✅ Now works
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
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFF2B2C6B),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              if (isUnread)
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2B2C6B),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
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