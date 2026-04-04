import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Themepracticeappstate.dart';

class Nastroyki extends StatelessWidget {
  const Nastroyki({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<Themepracticeappstate>(context);
    bool isDark = themeState.isDark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Настройки" ),
        
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: isDark ? const Color.fromARGB(58, 0, 0, 0) : const Color.fromARGB(31, 121, 115, 115), 
            height: 1.0
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: isDark ? const Color.fromARGB(255, 45, 42, 70) : const Color.fromARGB(255, 210, 207, 207),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: SwitchListTile(
                  title: Text(
                    'Темная тема',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Использовать темное оформление",
                    style: TextStyle(color: isDark ? const Color.fromARGB(179, 174, 164, 164) : Colors.black54),
                  ),
                  value: isDark,
                  onChanged: (bool value) {
                    themeState.toggleTheme();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}