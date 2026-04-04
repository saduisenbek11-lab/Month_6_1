import 'package:flutter/material.dart';
import 'package:flutter_application_8/Add/add.dart';
import 'package:flutter_application_8/nastroyki/Themepracticeappstate.dart';
import 'package:flutter_application_8/nastroyki/nastroyki.dart';
import 'package:provider/provider.dart';

class Task {
  String name;
  String description;
  bool isDone;
  DateTime createdAt;

  Task({
    required this.name,
    this.description = "",
    this.isDone = false,
    required this.createdAt,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];
  List<Task> filteredTasks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTasks = tasks;
    _searchController.addListener(_runFilter);
  }

  void _runFilter() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredTasks = List.from(tasks);
      } else {
        filteredTasks = tasks
            .where((task) =>
                task.name.toLowerCase().contains(query) ||
                task.description.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  void _naviagateToAddPage() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const AddPage()),
    );

    if (result != null) {
      setState(() {
        tasks.add(Task(
          name: result['name']!,
          description: result['description']!,
          isDone: false,
          createdAt: DateTime.now(),
        ));
        _runFilter();
      });
    }
  }

  void _editTask(int index) async {
    final taskToEdit = filteredTasks[index];
    final originalIndex = tasks.indexOf(taskToEdit);

    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => AddPage(task: tasks[originalIndex]),
      ),
    );

    if (result != null) {
      setState(() {
        tasks[originalIndex].name = result['name']!;
        tasks[originalIndex].description = result['description']!;
        _runFilter();
      });
    }
  }

  void _confirmDelete(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.delete_forever_outlined, color: Colors.red),
              SizedBox(width: 8),
              Text("Удалить", style: TextStyle(color: Colors.red)),
            ],
          ),
          content: Text("Вы уверены, что хотите удалить заметку '${task.name}'?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Отмена"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.remove(task);
                  _runFilter();
                });
                Navigator.pop(context);
              },
              child: const Text("Удалить", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.black, height: 1.0),
        ),
      ),
      endDrawer: PageNastroiki(title: widget.title),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Искать заметки',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return Dismissible(
                  key: ObjectKey(task),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    _confirmDelete(task);
                    return false;
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
                  child: InkWell(
                    onTap: () => _editTask(index),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  task.description.isEmpty
                                      ? "Нет описания"
                                      : task.description,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(Icons.more_vert, color: Colors.grey),
                                onSelected: (value) {
                                  if (value == 'delete') {
                                    _confirmDelete(task);
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.delete_outline, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Удалить', style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _formatTime(task.createdAt),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: _naviagateToAddPage,
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class PageNastroiki extends StatelessWidget {
  final String title;
  const PageNastroiki({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<Themepracticeappstate>(context);
    final isDark = themeState.isDark;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Меню", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: isDark ? Colors.white : Colors.black),
            title: const Text('Настройки'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Nastroyki()));
            },
          ),
        ],
      ),
    );
  }
}