import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nubb_flutter/data/data.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final MyData data = Get.find<MyData>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(() {
                  final totalTasks = data.histroyItem.length;

                  return Text(
                    "You have complete [$totalTasks] tasks",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500]),
                  );
                }),
              ),
            ),
            Obx(() => Expanded(
                  child: ListView.builder(
                    itemCount: data.histroyItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: ListTile(
                          title: Text(data.histroyItem[index].title! ?? ''),
                          subtitle: Text(
                            "${data.histroyItem[index].date} • ${data.histroyItem[index].priority}",
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                data.histroyItem.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
