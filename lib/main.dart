import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class Todo{
  String title;
  bool isDone;

  Todo(this.title, {this.isDone = false});

}

class _TodoPageState extends State<TodoPage> {

  List<Todo> todos = [];
  TextEditingController _controller = TextEditingController();

  void addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        todos.add(Todo(_controller.text));
        _controller.clear();
      });
    }
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleDone(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Tugas"),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Tugas Baru',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTodo,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text("Tambah", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              
                child: todos.isEmpty
                    ? Center(child: Text("Belum ada tugas", style: TextStyle(fontSize: 18, color: Colors.grey)))
                    : ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index){
                    return Card (
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Checkbox(
                            value: todos[index].isDone, 
                            onChanged: (value) => toggleDone(index),
                        ),
                        title: Text(
                          todos[index].title,
                          style: TextStyle(
                            decoration: todos[index].isDone
                                ? TextDecoration.lineThrough
                                : null,
                            color: todos[index].isDone ? Colors.grey : Colors.black,
                          )
                        ),
                        trailing: IconButton(
                            onPressed: () => deleteTodo(index),
                            icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    );
                  }
                )
            ),
          ],
        ),
      ),
    );
  }
}