import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp_1/add_toDo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String text = 'simple text';
  List<String> todoList = [];

  void addTodo({required String todoText}) {
    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
// Save an list of strings to 'items' key.
    await prefs.setStringList('toList', todoList);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      todoList = (prefs.getStringList('toList') ?? []).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Text('Drawer Data'),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo App'),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      height: 250,
                      child: AddTodo(
                        addTodo: addTodo,
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            todoList.removeAt(index);
                          });
                          updateLocalData();
                          Navigator.pop(context);
                        },
                        child: Text('Mark as done'),
                      ),
                    );
                  },
                );
              },
              title: Text(
                todoList[index],
              ),
            );
          }),
    );
  }
}
