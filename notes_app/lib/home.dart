import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final uidController = TextEditingController();
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
            trailing: IconButton(
                color: Colors.black,
                onPressed: () {
                  deleteNote(notes[index]);
                },
                icon: Icon(Icons.delete)
            ),
            onTap: (){
              titleController.text = notes[index].title;
              descController.text = notes[index].desc;
              uidController.text = notes[index].uid;
              noteUpdateDialog(titleController, descController,scaffoldContext);

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          noteAddDialog(scaffoldContext);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  noteAddDialog (BuildContext scaffoldContext) {
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
            onPressed: () async {
              String title = titleController.text.trim();
              String desc = descController.text.trim();

              if (title.isEmpty || desc.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter required fields!')));
              } else {
                Navigator.pop(context); // ✅ Close dialog first
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(await addNote(Note(uid: DateTime.now().toString(),title: title, desc: desc), scaffoldContext))
                    )
                );
              }

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
  }

  noteUpdateDialog (TextEditingController title,TextEditingController desc,BuildContext scaffoldContext) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update note'),
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
            onPressed: () async {

              String title = titleController.text.trim();
              String desc = descController.text.trim();
              String uid = uidController.text.trim();

              updateNote(Note(uid: uid,title: title, desc: desc));
              setState(() {}); // Optional: local UI update

              titleController.clear();
              descController.clear();
              uidController.clear();

              Navigator.pop(context);
            },
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

  }

  Future<void> getNotes() async {

    notes.clear();

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Notes').get();

    for (DocumentSnapshot doc in snapshot.docs) {

      var noteData = doc.data() as Map<String, dynamic>;
      notes.add(Note.fromMap(noteData));
    }
    setState(() {});
  }

  Future<String> addNote(Note note, BuildContext context) async {

    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection('Notes').doc(note.uid).set(Note.toMap(note)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
            content: Text('Added Successfully!')
        ),
      );
    });
    return "";
  }

  Future<void> deleteNote(Note note) async {

    await FirebaseFirestore.instance.collection('Notes').doc(note.uid).delete().then((value){
      print('Deleted Successfully!');
      setState(() {});
      getNotes();
    });
  }

  Future<void> updateNote(Note note) async {
    await FirebaseFirestore.instance.collection('Notes').doc(note.uid).update(Note.toMap(note));
  }


}
