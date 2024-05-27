import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/data.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
            child: const Icon(
              Icons.check,
              color: Colors.green,
              size: 64,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Task Manager",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "version 1.0",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Get.find<MyData>().clearAllData();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Data has been cleareds successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            ),
            child: const Text(
              "CLEAR ALL DATA",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          TextButton(
              onPressed: () {},
              child: const Text(
                "Terms and Conditions",
                style: TextStyle(color: Colors.red),
              )),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {},
              child: const Text("Pravcy and Policy",
                  style: TextStyle(color: Colors.red))),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const Spacer(),
          const Text("Cloned by Morm Borenn",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
