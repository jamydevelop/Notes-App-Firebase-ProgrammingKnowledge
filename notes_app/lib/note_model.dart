class Note {
  String? title;
  String? desc;

  Note({this.title, this.desc});

  static Map<String, dynamic> toMap(Note note) {
    return {
      'title': note.title,
      'desc': note.desc,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
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
