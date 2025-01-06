import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Add todo:'),
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
              print(todoText.text);
              todoText.text = "";
            },
            child: Text('Add'))
      ],
    );
  }
}
