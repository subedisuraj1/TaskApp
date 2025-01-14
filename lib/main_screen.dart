import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp_1/add_toDo.dart';
import 'package:todoapp_1/todo_list.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String text = 'simple text';
  List<String> todoList = [];

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Already exists"),
              content: Text("This data already exists in your todo list"),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("close"))
              ],
            );
          });
      return;
    }
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
  void initState() {
    loadData();
    super.initState();
  }

  void showAddTodoBottomSheet() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.blueGrey[900],
                child: Center(
                  child: Text(
                    "Todo App",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse(
                      "https://www.facebook.com/profile.php?id=100061020606477"));
                },
                leading: Icon(Icons.person),
                title: Text(
                  'About Me',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("mailto:someone@example.com"));
                },
                leading: Icon(Icons.email),
                title: Text(
                  "Contact me",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Todo App'),
          actions: [
            InkWell(
              onTap: showAddTodoBottomSheet,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
        body: TodoList(todoList: todoList, updateLocalData: updateLocalData));
  }
}
