import 'dart:async';

import 'package:flutter/material.dart';

import 'home.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[200]),
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
            )
          ],
        ),
      ),
    );
  }
}
