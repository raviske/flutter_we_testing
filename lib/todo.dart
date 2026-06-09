import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class To extends StatefulWidget {
  final String title;
  To({super.key, required this.title});

  @override
  State<To> createState() => _ToState();
}

class _ToState extends State<To> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> todos = [];
  void addtodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // todos = prefs.getStringList('todos') ?? [];
    todos.add(_textEditingController.text);
    await prefs.setStringList('todos', todos);
    setState(() {});
  }

  void getTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todos = prefs.getStringList('todos') ?? [];
    });
  }

  void deleteTodo(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todos.removeAt(index);
    await prefs.setStringList('todos', todos);
    setState(() {
      todos = prefs.getStringList('todos') ?? [];
    });
  }

  void editTodo(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todos[index] = _textEditingController.text;
    await prefs.setStringList('todos', todos);
    setState(() {
      todos = prefs.getStringList('todos') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addtodo();
          Future.delayed(Duration(seconds: 1), () {
            getTodos();
            _textEditingController.clear();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: 'Add a new todo'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    todos[index],
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      editTodo(index);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      deleteTodo(index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
