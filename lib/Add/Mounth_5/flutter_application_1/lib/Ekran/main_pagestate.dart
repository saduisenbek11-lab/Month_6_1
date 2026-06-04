import 'package:flutter/material.dart';
import 'package:flutter_application_1/Ekran/favourite_page.dart';
import 'package:flutter_application_1/Ekran/newsListpage.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const NewsListPage(),
      const FavouritePage(),
      const SizedBox(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => index = 0),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () => setState(() => index = 1),
            ),
            const Icon(Icons.menu),
          ],
        ),
      ),
    );
  }
}