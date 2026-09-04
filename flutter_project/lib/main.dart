import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillbridge/utils/user_state.dart';
import 'package:skillbridge/utils/theme_provider.dart';
import 'package:skillbridge/utils/user_data_provider.dart';
import 'package:skillbridge/screens/welcome_screen.dart';
import 'package:skillbridge/screens/login_screen.dart';
import 'package:skillbridge/screens/signup_screen.dart';
import 'package:skillbridge/screens/onboard1_screen.dart';
import 'package:skillbridge/screens/onboard2_screen.dart';
import 'package:skillbridge/screens/onboard3_screen.dart';
import 'package:skillbridge/screens/home_screen.dart';
import 'package:skillbridge/screens/discovery_screen.dart';
import 'package:skillbridge/screens/messages_screen.dart';
import 'package:skillbridge/screens/sessions_screen.dart';
import 'package:skillbridge/screens/profile_screen.dart';
import 'package:skillbridge/screens/mentor_profile_screen.dart';
import 'package:skillbridge/screens/settings_screen.dart';
import 'package:skillbridge/screens/edit_profile_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ],
      child: const SkillBridgeApp(),
    ),
  );
}

class SkillBridgeApp extends StatelessWidget {
  const SkillBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'SkillBridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto',
        primaryColor: const Color(0xFF2B2C6B),
        scaffoldBackgroundColor: const Color(0xFFEFF1F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2B2C6B),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        brightness: Brightness.light,
        cardColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2B2C6B),
          secondary: Color(0xFF4A4A8A),
          surface: Colors.white,
        ),
        dividerColor: Colors.grey,
      ),
      darkTheme: ThemeData(
        fontFamily: '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto',
        primaryColor: const Color(0xFF1A1A2E),
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF16213E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        brightness: Brightness.dark,
        cardColor: const Color(0xFF2D2D44),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2B2C6B),
          secondary: Color(0xFF4A4A8A),
          surface: Color(0xFF2D2D44),
        ),
        dividerColor: Colors.white24,
      ),
      themeMode: themeProvider.themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/onboard1': (context) => const Onboard1Screen(),
        '/onboard2': (context) => const Onboard2Screen(),
        '/onboard3': (context) => const Onboard3Screen(),
        '/home': (context) => const HomeScreen(),
        '/discovery': (context) => const DiscoveryScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/sessions': (context) => const SessionsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/mentor_profile': (context) => const MentorProfileScreen(
          name: '',
          role: '',
          initial: '',
        ),
        '/settings': (context) => const SettingsScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
      },
    );
  }
}