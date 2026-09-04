import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbridge/utils/dialog_utils.dart';
import 'package:skillbridge/utils/user_state.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  bool showUpcoming = true;

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

    // Debug
    print('📅 SessionsScreen: isNewUser = $isNewUser');

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sessions',
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
                  const SizedBox(height: 5),
                  Text(
                    'Manage your career meetings',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white60 : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ CONDITIONAL: Empty state for new users
                  if (isNewUser)
                    _buildEmptyState(
                      icon: Icons.calendar_month,
                      title: 'No Sessions Yet',
                      subtitle: 'Book your first session with a mentor to get started!',
                      buttonText: 'Find a Mentor',
                      onPressed: () => Navigator.pushReplacementNamed(context, '/discovery'),
                      isDarkMode: isDarkMode,
                    )
                  else
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showUpcoming = true;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: showUpcoming
                                      ? const Color(0xFF2B2C6B)
                                      : Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Upcoming',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: showUpcoming ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showUpcoming = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: !showUpcoming
                                      ? const Color(0xFF2B2C6B)
                                      : Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Past',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: !showUpcoming ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (showUpcoming) ...[
                          _buildSessionCard(
                            title: 'Career Mentorship with Kim',
                            tag: '1 on 1',
                            date: 'Tomorrow, 3:00 PM',
                            duration: '60 min',
                            isDarkMode: isDarkMode,
                          ),
                          _buildSessionCard(
                            title: 'Resume Workshop',
                            tag: 'Group',
                            date: 'Fri, 15 Aug, 10:00 AM',
                            duration: '90 min',
                            isDarkMode: isDarkMode,
                          ),
                          _buildSessionCard(
                            title: 'Tech Career Networking',
                            tag: 'Event',
                            date: 'Mon, 18 Aug, 6:00 PM',
                            duration: '2 hours',
                            isDarkMode: isDarkMode,
                          ),
                        ] else ...[
                          _buildSessionCard(
                            title: '1-on-1 Mentorship with Sarah',
                            tag: 'Completed',
                            date: 'Mon, 4 Aug, 2:00 PM',
                            duration: '45 min',
                            isPast: true,
                            isDarkMode: isDarkMode,
                          ),
                          _buildSessionCard(
                            title: 'React Hooks Masterclass',
                            tag: 'Completed',
                            date: 'Wed, 30 Jul, 6:00 PM',
                            duration: '90 min',
                            isPast: true,
                            isDarkMode: isDarkMode,
                          ),
                          _buildSessionCard(
                            title: 'Resume Review with Kim',
                            tag: 'Completed',
                            date: 'Thu, 25 Jul, 10:00 AM',
                            duration: '30 min',
                            isPast: true,
                            isDarkMode: isDarkMode,
                          ),
                          _buildSessionCard(
                            title: 'Tech Career Networking Night',
                            tag: 'Completed',
                            date: 'Tue, 16 Jul, 7:00 PM',
                            duration: '2 hours',
                            isPast: true,
                            isDarkMode: isDarkMode,
                          ),
                        ],
                      ],
                    ),
                ],
              ),
            ),
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
                      isActive: false,
                      onTap: () => Navigator.pushReplacementNamed(context, '/messages'),
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.calendar_today,
                      label: 'Sessions',
                      isActive: true,
                      onTap: () {},
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

  Widget _buildSessionCard({
    required String title,
    required String tag,
    required String date,
    required String duration,
    required bool isDarkMode,
    bool isPast = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isPast ? const Color(0xFFE5E5E5) : const Color(0xFFEFF1F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isPast ? Colors.grey : const Color(0xFF2B2C6B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
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