import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  final List<Note> notes = [];

  @override
  void initState() {
    getNotes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final scaffoldContext = context; // ✅ Save scaffold context

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Notes App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              getNotes();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: notes.isEmpty
          ? const Center(
        child: Text(
          'No notes yet',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          Note note = notes[index];
          return ListTile(
            leading: Text(
              note.title[0].toUpperCase(),
              style: const TextStyle(fontSize: 20),
            ),
            title: Text(note.title),
            subtitle: Text(note.desc),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add note'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Title",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Description",
                    ),
                  ),
                ],
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // Cancel button
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    String title = titleController.text.trim();
                    String desc = descController.text.trim();

                    Navigator.pop(context); // ✅ Close dialog first

                    addNote(Note(title: title, desc: desc), scaffoldContext); // ✅ Use scaffold context

                    setState(() {}); // Optional: local UI update

                    titleController.clear();
                    descController.clear();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  // ✅ This method adds note and shows a SnackBar
  addNote(Note note, BuildContext context) async {
    
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection('Notes').doc(DateTime.now().toString()).set(Note.toMap(note)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
            content: Text('Added Successfully!')
        ),
      );
    });
  }

  getNotes() async {

    notes.clear();

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Notes').get();

    for (DocumentSnapshot doc in snapshot.docs) {

      var noteData = doc.data() as Map<String, dynamic>;
      notes.add(Note.fromMap(noteData));
    }
    setState(() {});
  }
}
