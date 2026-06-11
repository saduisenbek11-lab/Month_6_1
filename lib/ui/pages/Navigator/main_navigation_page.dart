import 'package:flutter/material.dart';
import 'package:flutter_application_88/data/local/app_database.dart';
import '../quiz_first_page.dart';
import '../History/history_page.dart';
import '../Settings/settings_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    HistoryPage(database: AppDatabase.instance),  
    const QuizSetupPage(),                         
    SettingsPage(database: AppDatabase.instance), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF8E6CFF),
          unselectedItemColor: Colors.black26,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined, size: 28),
              activeIcon: Icon(Icons.history, size: 28),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined, size: 28),
              activeIcon: Icon(Icons.explore, size: 28),
              label: 'Quiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 28),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}