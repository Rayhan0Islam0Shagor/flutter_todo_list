import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  void Function({required String todoText}) addTodo;

  AddTodo({super.key, required this.addTodo});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text("Add todo"),
          const SizedBox(height: 6),
          TextField(
            autofocus: true,
            controller: todoText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Todo',
              hintText: "Enter todo",
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                widget.addTodo(todoText: value);
                todoText.clear();
              }
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (todoText.text.trim().isNotEmpty) {
                widget.addTodo(todoText: todoText.text);
                todoText.clear();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
