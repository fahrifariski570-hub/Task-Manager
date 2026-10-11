import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/add_task_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> deleteTask(int id) async {
    final response = await http.post(
      Uri.parse("http://localhost/task_manager_api/delete_task.php"),
      body: {"id": id.toString()},
    );

    if (response.statusCode == 200) {
      gettasks();
    }
  }

  Future<void> updateTask(int id, int isCompleted) async {
    final response = await http.post(
      Uri.parse("http://localhost/task_manager_api/update_task.php"),
      body: {"id": id.toString(), "is_completed": isCompleted.toString()},
    );

    debugPrint("Status: ${response.statusCode}");
    debugPrint("Response: ${response.body}");

    if (response.statusCode == 200) {
      gettasks();
    }
  }

  List<dynamic> tasks = [];
  Future<void> gettasks() async {
    final response = await http.get(
      Uri.parse("http://localhost/task_manager_api/get_tasks.php"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        tasks = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gettasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Evening",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 8),
            Text("3 Task Remaining"),
            SizedBox(height: 24),
            Text("TODAY"),
            SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  final id = int.parse(task["id"].toString());

                  final isCompleted = task["is_completed"].toString() == "1";

                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: isCompleted,
                        onChanged: (value) {
                          updateTask(id, value == true ? 1 : 0);
                        },
                      ),
                      title: Text(task["title"].toString()),
                      subtitle: Text(task["description"].toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteTask(id);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );

          if (result == true) {
            gettasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
