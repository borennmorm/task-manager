import 'package:get/get.dart';

import '../model/model.dart';

class MyData extends GetxController {
  var itemTodo = [].obs;
  var histroyItem = [].obs;

  void addItem(String title, String date, String priority) {
    itemTodo.add(TodoItem(title, date, priority, false));
  }

  void completeTask(int index) {
    if (itemTodo.isNotEmpty && index >= 0 && index < itemTodo.length) {
      TodoItem completedTask = itemTodo.removeAt(index);
      completedTask.isDone = true;
      histroyItem.add(completedTask);
    }
  }

  void clearAllData() {
    itemTodo.clear();
    histroyItem.clear();
  }
}
