import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  
  String _infoMessage = '';
  Color _messageColor = Colors.red; 

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _controller.text.trim());
    } else {
      setState(() {
        _infoMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Новая задача"),
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
                  onChanged: (value) {
                    if (_infoMessage.isNotEmpty) {
                      setState(() => _infoMessage = '');
                    }
                  },
                ),
                const SizedBox(height: 12),
                if (_infoMessage.isNotEmpty)
                  Text(
                    _infoMessage,
                    style: TextStyle(
                      color: _messageColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                const SizedBox(height: 460), 
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 140, 255),
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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