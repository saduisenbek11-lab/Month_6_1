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
  List<Task> tasks = [];

  void _naviagateToAddPage() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const AddPage()),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        tasks.add(Task(name: result, isDone: false));
      });
    }
  }

  void _editTask(int index) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => AddPage(task: tasks[index]),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        tasks[index].name = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
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
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      tasks.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Задача удалена")),
                    );
                  },
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: GestureDetector(
                    onTap: () => _editTask(index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 4, 136, 252),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              tasks[index].isDone
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                tasks[index].isDone = !tasks[index].isDone;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
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
}

class PageNastroiki extends StatelessWidget {
  final String title;
  const PageNastroiki({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Themepracticeappstate>(context).isDark;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              "Меню",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings,
                color: isDark ? Colors.white : Colors.black),
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