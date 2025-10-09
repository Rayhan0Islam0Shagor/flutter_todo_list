import 'package:flutter/material.dart';

class TodoListBuilder extends StatefulWidget {
  List<String> todoList = [];
  void Function() updateLocalData;
  TodoListBuilder({
    super.key,
    required this.todoList,
    required this.updateLocalData,
  });

  @override
  State<TodoListBuilder> createState() => _TodoListBuilderState();
}

class _TodoListBuilderState extends State<TodoListBuilder> {
  void onItemClick({required int index}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() {
                widget.todoList.removeAt(index);
              });
              widget.updateLocalData();
              Navigator.pop(context);
            },
            child: const Text("Done"),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.todoList.isEmpty
        ? const Center(child: Text("No data found!"))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.green.shade300,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.check),
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todoList.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  onTap: () {
                    onItemClick(index: index);
                  },
                  title: Text(widget.todoList[index]),
                ),
              );
            },
          );
  }
}
