import 'package:flutter/material.dart';

class Hometelegrampage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const Hometelegrampage({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  State<Hometelegrampage> createState() => _HometelegrampageState();
}

class _HometelegrampageState extends State<Hometelegrampage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.dark 
                  ? Icons.wb_sunny 
                  : Icons.nights_stay,
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: const Center(
        child: Text(""),
      ),
    );
  }
}