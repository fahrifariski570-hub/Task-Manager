import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  Future<void> addTask() async {
    final response = await http.post(
      Uri.parse("http://localhost/task_manager_api/add_task.php"),
      body: {
        "title": _judulController.text,
        "description": _deskripsiController.text,
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      Navigator.pop(context, true);
    }
  }

  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Task"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("Tambah Task"),
            SizedBox(height: 8),
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                labelText: "Judul Task",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: "Deskripsi",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(onPressed: addTask, child: Text("Simpan")),
          ],
        ),
      ),
    );
  }
}
