import 'package:flutter/material.dart';
import 'package:flutter_application_3/Ekran/second.dart';

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  centerTitle: true,
  title: const Text(
    "                                                               Пропустить",
    style: TextStyle(
      color: Color.fromARGB(148, 164, 161, 161),
    ),
  ),
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(1.0),
    child: Container(color: const Color.fromARGB(187, 50, 49, 49), height: 1.0),
  ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('images/Lini.jpg',
             width: 200, 
             height: 200, 
             fit: BoxFit.cover, ),
            SizedBox(height: 10),
            Text(
              "Todolist",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 10),
            Text(
              "Добро пожаловать!",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500,),
            ),
            SizedBox(height: 5),
            Text(
              "Oрганизуйте свою жизнь",
              style: TextStyle(fontSize: 22, color: Color.fromARGB(172, 81, 80, 80), height: 1.3),
            ),
            Text(
              "с Todolist-приложение для ",
              style: TextStyle(fontSize: 22, color: Color.fromARGB(172, 81, 80, 80), height: 1.3),
            ),
            Text(
              "управления задачами",
              style: TextStyle(fontSize: 22, color: Color.fromARGB(172, 81, 80, 80), height: 1.3),
            ),
            SizedBox(height: 10),
            Image.asset('images/twin.jpg',
             width: 250, 
             height: 200, 
             fit: BoxFit.cover, ),
          ]
        ),
      ),
 floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, 
          children: [
            ElevatedButton.icon(
              onPressed: () => _navigateToSecond(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Далее", style: TextStyle(fontSize: 18)),
            ),
          ], 
        ), 
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _navigateToSecond(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Second()),
    );
  }
}