import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_3/Add/add.dart';
import 'package:flutter_application_3/DataBase/app_database.dart';
import 'package:flutter_application_3/nastroyki/Themepracticeappstate.dart';
import 'package:flutter_application_3/nastroyki/nastroyki.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    void _naviagateToAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddPage()),
    );
  }
  void _editTask(Todo task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddPage(task: task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

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
            child: StreamBuilder<List<Todo>>(
              stream: database.select(database.todos).watch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tasks = snapshot.data ?? [];

                if (tasks.isEmpty) {
                  return const Center(child: Text("Задач пока нет"));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {

                    final item = tasks[index];

                    return Dismissible(
                      key: Key(item.id.toString()), 
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        database.deleteTodo(item.id); 
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
                        onTap: () => _editTask(item),
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
                                  Icons.check_box_outline_blank, 
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                },
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: const TextStyle(
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