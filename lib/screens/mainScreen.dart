import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hello_flutter_app/screens/addTodo.dart';
import 'package:hello_flutter_app/widgets/todoList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];
  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("$todoText already exists"),
          content: const Text("This data already exists"),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Close"),
              ),
            ),
          ],
        ),
      );

      return;
    }

    setState(() {
      // todoList.add(todoText);
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // save todo list
    prefs.setStringList('todoList', todoList);
  }

  void loadData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList('todoList') ?? []).toList();

    setState(() {});
  }

  void displayBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 300,
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: AddTodo(addTodo: addTodo),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blueGrey[900],
        onPressed: displayBottomSheet,
        child: Icon(Icons.add, color: Colors.white),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[900],
              height: 200,
              width: double.infinity,
              child: const Center(
                child: Text(
                  "Todo App",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            ListTile(
              onTap: () {
                launchUrl(
                  Uri.parse("https://rayhan-islam-portfolio.vercel.app"),
                );
              },
              leading: const Icon(Icons.person),
              title: const Text(
                "About Me",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Todo App!",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: displayBottomSheet,
              radius: 24,
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(FeatherIcons.plus, color: Colors.black),
              ),
            ),
          ),
        ],
      ),

      body: TodoListBuilder(
        todoList: todoList,
        updateLocalData: updateLocalData,
      ),
    );
  }
}
