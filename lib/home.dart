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
                },
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        Text(
                          tasks.isNotEmpty ? tasks[0]["title"] : "loading. . .",
                        ),
                        Text(tasks.isNotEmpty ? tasks[0]["title"] : ""),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle_outline),
                    SizedBox(width: 12),
                    Column(children: [Text("Latihan Git"), Text("Complated")]),
                  ],
                ),
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
