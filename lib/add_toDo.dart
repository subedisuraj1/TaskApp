import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  final void Function({required String todoText}) addTodo;

  const AddTodo({super.key, required this.addTodo});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              hintText: "Write your todo here...",
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            controller: todoText,
          ),
          ElevatedButton(
              onPressed: () {
                if (todoText.text.isNotEmpty) {
                  widget.addTodo(todoText: todoText.text);
                }
                todoText.text = "";
              },
              child: Text('Add'))
        ],
      ),
    );
  }
}
