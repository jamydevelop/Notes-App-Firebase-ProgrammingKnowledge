import 'package:flutter/material.dart';
import 'package:notes_app/note_model.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final titleController = TextEditingController();
  final descController = TextEditingController();

  final List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
            'Notes App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )
          )
        ],
      ),
      body: notes.isEmpty
          ? Center(
              child: Container(
                child: Text(
                  'No notes yet',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  )
                )
              )
            )
         :
          ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context,index) {
              Note note = notes[index];
              return ListTile(
                leading: Text(
                    note.title[0].toUpperCase(),
                  style: TextStyle(fontSize: 20),
                ),
                title: Text(note.title),
                subtitle: Text(note.desc),
              );
            }
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(context: context, builder: (context) => AlertDialog(
            title: Text('Add note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Title"
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Description"
                  ),
                ),
              ],
            ),
          ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
