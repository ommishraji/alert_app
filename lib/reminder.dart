class reminder{
  int? uid;
  late String title, description;
  late DateTime dateTime;
  reminder({this.uid, required this.title, required this.description, required this.dateTime});

  Map<String, dynamic> tomap(){
    return{
      'uid': uid,
      'title': title,
      'description': description,
      'dateTime': dateTime.toString(),
    };
  }

  factory reminder.fromMap(Map<String, dynamic> map){
    return reminder(
        uid: map['uid'],
        title: map['title'],
        description: map['description'],
        dateTime: DateTime.parse(map['datetime'])
    );
  }
}