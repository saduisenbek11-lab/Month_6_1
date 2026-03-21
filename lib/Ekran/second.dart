import 'package:flutter/material.dart';
import 'first.dart';
import 'package:flutter_application_3/Home/home.dart';
class Second extends StatelessWidget {
  const Second({super.key});

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GestureDetector(
          onTap: () => _navigateToHome(context),
          child: const Text(
            "                                                     Пропустить",
            style: TextStyle(color: Color.fromARGB(148, 164, 161, 161)),
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
             Image.asset('images/kol.jpg',
             width: 250, 
             height: 250, 
             fit: BoxFit.cover, ),
            SizedBox(height: 20), 
            Text(
              "Все задачи",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, ),
            ),
            Text(
              "в одном месте",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, height: 1.0),
            ),
            SizedBox(height: 10),
            Text(
              "Добавляйте, упорядочивайте",
              style: TextStyle(fontSize: 22, color: Color.fromARGB(172, 81, 80, 80), height: 1.0),
            ),
            Text(
              "и управляйте задачами на день,",
              style: TextStyle(fontSize: 22, color: Color.fromARGB(172, 81, 80, 80), height: 1.0),
            ),
            Text(
              "неделю и месяц",
              style: TextStyle(fontSize: 22, color: Color.fromARGB(172, 81, 80, 80), height: 1.0),
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
     floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const First()),
                );
              },
              icon: const Icon(Icons.arrow_back, color: Colors.grey),
              label: const Text(
                "Назад",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),

  
            ElevatedButton.icon(
              onPressed: () => _navigateToHome(context),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      );
 }
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(title: "Ваши задачи"),
      ),
    );
  }
} 