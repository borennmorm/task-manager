import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/data.dart';

class UpdateView extends StatefulWidget {
  final MyData data;
  final int index;

  const UpdateView({super.key, required this.data, required this.index});

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _errorText;
  DateTime selectedDate = DateTime.now();
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize text fields and dropdown button with task data
    _controller.text = widget.data.itemTodo[widget.index].title!;
    _dateController.text = widget.data.itemTodo[widget.index].date!;
    selectedValue = widget.data.itemTodo[widget.index].priority!;
  }

  void _validateInput() {
    setState(() {
      if (_controller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter title')),
        );
      } else if (RegExp(r'^[0-9]+$').hasMatch(_controller.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Title cannot contain only numbers')),
        );
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
        title: const Text('Update'),
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
                value: selectedValue, // Set the selected value
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
                  setState(() {
                    selectedValue = value; // Update the selected value
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.data.itemTodo.removeAt(widget.index);
                      });
                      // Close the update view after deleting
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _validateInput();

                      if (_errorText == null &&
                          selectedValue != null &&
                          _dateController.text.isNotEmpty) {
                        MyData data = Get.find<MyData>();

                        // Update the task
                        data.itemTodo[widget.index].title = _controller.text;
                        data.itemTodo[widget.index].date = _dateController.text;
                        data.itemTodo[widget.index].priority = selectedValue!;

                        // Close the update view
                        Navigator.pop(context);

                        Get.forceAppUpdate();
                      } else {
                        if (selectedValue == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please select a priority')),
                          );
                        }
                        if (_dateController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please select a date')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
