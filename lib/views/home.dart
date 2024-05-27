import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/data.dart';
import 'update.dart';
import 'package:slide_up_panel/slide_up_panel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final MyData data = Get.find<MyData>();
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              "Task",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "Manager",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.apps),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history/');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/setting/');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask/');
        },
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                final totalTasks = data.itemTodo.length;
                final pendingTasks =
                    data.itemTodo.where((item) => !item.isDone!).length;
                return Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "You have $pendingTasks pending task(s) out of $totalTasks",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                );
              }),
            ),
            Expanded(
              child: Obx(() {
                final tasks = data.itemTodo;
                return tasks.isEmpty
                    ? const Center(
                        child: Text('No tasks available'),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          final task = tasks[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: ListTile(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateView(index: index, data: data),
                                  ),
                                );
                              },
                              title: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  task.title!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              subtitle: Text(
                                "${task.date} • ${task.priority}",
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Checkbox(
                                value: task.isDone,
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    data.completeTask(index);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
