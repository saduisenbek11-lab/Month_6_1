import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/DataBase/app_database.dart';
import 'package:flutter_application_3/main.dart';

class AddPage extends StatefulWidget {
  final Task? task; 

  const AddPage({super.key, this.task});

  @override
  State<AddPage> createState() => Taskdetailpage();
}

class Taskdetailpage extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  String _infoMessage = '';
  Color _messageColor = Colors.green;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task?.name ?? '');
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _controller.text);
    }
  }
  @override
 Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.task == null ? "Новая задача" : "Редактировать"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.black12, height: 1.0),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                TextFormField(
                  controller: _controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Название задачи",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Название не может быть пустым';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                if (_infoMessage.isNotEmpty)
                  Text(
                    _infoMessage,
                    style: TextStyle(color: _messageColor, fontWeight: FontWeight.w500),
                  ),
                const SizedBox(height: 40), 
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 140, 255),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: Text(
                    widget.task == null ? "Сохранить" : "Oбновить",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}