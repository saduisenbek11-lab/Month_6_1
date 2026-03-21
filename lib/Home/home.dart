
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Add/add.dart';
import 'package:flutter_application_3/nastroyki/Themepracticeappstate.dart';
import 'package:flutter_application_3/nastroyki/nastroyki.dart';
import 'package:provider/provider.dart';

class Task {
  String name;
  bool isDone;
  Task({required this.name, this.isDone = false});
}
class MyHomePage extends StatefulWidget {
  
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  late final  cubit ;
  List<Task> tasks = [];
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        widget.title,
        style: const TextStyle(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: Colors.black, height: 1.0),
      ),
    ),
    drawer: PageNastroiki(title: widget.title),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      tasks[index].isDone = !tasks[index].isDone;
                    });
                  },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 4, 136, 252),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        tasks[index].isDone
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tasks[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ), 
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: _naviagateToAddPage,
      label: const Text("Добавить задачу"),
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.add),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );
}

void _naviagateToAddPage() async {
  final result = await Navigator.push<String>(
    context,
    MaterialPageRoute(builder: (_) => const AddPage()),
  );
  
  if (result != null && result.isNotEmpty) {
    setState(() {
      tasks.add(Task(name: result));
    });
  }
}
}class PageNastroiki extends StatelessWidget {
  final String title;
  const PageNastroiki({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Themepracticeappstate>(context).isDark;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 255, 255, 255),
            ),
            child: const Text(
              "Меню",
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: isDark ? Colors.white : const Color.fromARGB(221, 0, 0, 0)),
            title: const Text('Настройки'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Nastroyki()),
              );
            },
          ),
        ],
      ),
    );
  }
}