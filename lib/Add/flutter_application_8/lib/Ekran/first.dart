import 'package:flutter/material.dart';
import 'second.dart'; 
import'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_8/Home/home.dart';

class First extends StatelessWidget {
  const First({super.key});

  Future<void> _skipOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSeen', true);

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Заметки')),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => _skipOnboarding(context),
            child: const Text(
              "Пропустить",
              style: TextStyle(color: Color.fromARGB(148, 164, 161, 161)),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
              color: const Color.fromARGB(187, 50, 49, 49), height: 1.0),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/Lini.jpg',
                  width: 200, height: 200, fit: BoxFit.cover),
              const SizedBox(height: 10),
              const Text("Ваши заметки",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const Text("Добро пожаловать!",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500)),
              const SizedBox(height: 15),
              const Text(
                "Организуйте свою жизнь\nс Заметками-приложение для\nуправления задачами",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(172, 81, 80, 80),
                    height: 1.3),
              ),
              const SizedBox(height: 20),
              Image.asset('images/twin.jpg',
                  width: 250, height: 200, fit: BoxFit.cover),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Second()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.arrow_forward),
          label: const Text("Далее", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
} 