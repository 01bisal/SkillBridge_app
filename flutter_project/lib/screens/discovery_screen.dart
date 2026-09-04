import 'package:flutter/material.dart';
import 'package:skillbridge/utils/dialog_utils.dart';
import 'package:skillbridge/screens/mentor_profile_screen.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> _allMentors = [
    {
      'initial': 'J',
      'name': 'Jane Doe',
      'role': 'UX Designer @ Atlassian',
    },
    {
      'initial': 'M',
      'name': 'Michael Chen',
      'role': 'Dev @ Canva',
    },
    {
      'initial': 'S',
      'name': 'Sarah Williams',
      'role': 'Recruiter @ Google',
    },
    {
      'initial': 'R',
      'name': 'Robert Kim',
      'role': 'Data Scientist @ AWS',
    },
    {
      'initial': 'P',
      'name': 'Priya Patel',
      'role': 'Product Manager @ Atlassian',
    },
  ];

  List<Map<String, String>> get _filteredMentors {
    if (_searchQuery.isEmpty) {
      return _allMentors;
    }
    return _allMentors.where((mentor) {
      return mentor['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          mentor['role']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _showLogoutDialog(BuildContext context) async {
    final confirm = await DialogUtils.showStyledLogoutDialog(context);
    if (confirm == true && context.mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        'Discovery',
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
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search Box
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                      children: [
                        Icon(
                          Icons.search,
                          color: isDarkMode ? Colors.white60 : Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search mentors, topics, skills...',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: isDarkMode ? Colors.white60 : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        if (_searchQuery.isNotEmpty)
                          IconButton(
                            icon: Icon(Icons.clear, size: 18,
                                color: isDarkMode ? Colors.white60 : Colors.grey),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Categories
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildCategoryItem(Icons.laptop, 'Tech', isDarkMode),
                      _buildCategoryItem(Icons.brush, 'Design', isDarkMode),
                      _buildCategoryItem(Icons.trending_up, 'Marketing', isDarkMode),
                      _buildCategoryItem(Icons.work, 'Business', isDarkMode),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // Top Mentors
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Mentors',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        Text(
                          '${_filteredMentors.length} results',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (_filteredMentors.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text(
                          'No mentors found',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white60 : Colors.grey,
                          ),
                        ),
                      ),
                    )
                  else
                    ..._filteredMentors.map((mentor) {
                      return _buildMentorCard(
                        initial: mentor['initial']!,
                        name: mentor['name']!,
                        role: mentor['role']!,
                        isDarkMode: isDarkMode,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MentorProfileScreen(
                                name: mentor['name']!,
                                role: mentor['role']!,
                                initial: mentor['initial']!,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
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
                      isActive: true,
                      onTap: () {},
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

  Widget _buildCategoryItem(IconData icon, String label, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Showing $label mentors'),
            duration: const Duration(seconds: 1),
            backgroundColor: const Color(0xFF2B2C6B),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: const Color(0xFF2B2C6B),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMentorCard({
    required String initial,
    required String name,
    required String role,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Connection request sent!'),
                    backgroundColor: Color(0xFF2B2C6B),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B2C6B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Connect',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
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