class Note {
  String uid;
  String title;
  String desc;

  Note({ required this.uid, required this.title,required this.desc});

  static Map<String, dynamic> toMap(Note note) {
    return {
      'uid' : note.uid,
      'title': note.title,
      'desc': note.desc,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      uid: map['uid'],
      title: map['title'],
      desc: map['desc'],
    );
  }
}

// class Note {
//   String? title;
//   String? desc;
//
//   Note({this.title,this.desc});
//
//   static toMap(Note note) {
//     return {
//       'title': note.title,
//       'desc': note.desc
//     };
//   }
//
//   factory Note.fromMap(Map<String,dynamic> map){
//     return Note(map["title"] , map["desc"]);
//   }
// }
