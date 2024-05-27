import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nubb_flutter/views/add.dart';
import 'package:nubb_flutter/views/history.dart';
import 'package:nubb_flutter/views/loading.dart';
import 'package:nubb_flutter/views/setting.dart';

import 'data/data.dart';

void main() {
  MyData data = MyData();
  Get.put(data);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoadingView(),
      routes: {
        '/addTask/': (context) => const AddTaskViews(),
        '/history/': (context) => const HistoryView(),
        '/setting/': (context) => const SettingView(),
      },
    );
  }
}
