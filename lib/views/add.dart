import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/data.dart';

class AddTaskViews extends StatefulWidget {
  const AddTaskViews({super.key});

  @override
  State<AddTaskViews> createState() => _AddTaskViewsState();
}

class _AddTaskViewsState extends State<AddTaskViews> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _errorText;
  DateTime selectedDate = DateTime.now();
  String? selectedValue;

  void _validateInput() {
    setState(() {
      if (_controller.text.isEmpty) {
        _errorText = 'Title cannot be empty';
      } else {
        _errorText = null;
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('MMM dd, yyyy').format(selectedDate);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  labelText: 'Title',
                  errorText: _errorText,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Date",
                ),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: "Low",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Low",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Medium",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Medium",
                          style: TextStyle(color: Colors.orange),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: "High",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "High",
                          style: TextStyle(color: Colors.red),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  selectedValue = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _validateInput();

                  if (_errorText == null &&
                      selectedValue != null &&
                      _dateController.text.isNotEmpty) {
                    MyData data = Get.find<MyData>();
                    data.addItem(
                      _controller.text,
                      _dateController.text,
                      selectedValue!,
                    );

                    Navigator.pop(context);
                  } else {
                    if (selectedValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a priority')),
                      );
                    }
                    if (_dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 145, vertical: 15),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
