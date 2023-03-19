import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String id;
  String name;
  List<String> admins;
  List<String> users;

  Group(
      {required this.id,
      required this.name,
      required this.users,
      required this.admins});
}

extension GroupEntityParser on Group {
  static Group fromSnapshot(DocumentSnapshot snap) {
    var n = snap['name'];
    var a = snap['admins'];
    List<String> admins = List<String>.from(a);
    var u = snap['users'];
    List<String> users = List<String>.from(u);

    return Group(
        id: snap.id,
        name: n,
        admins: admins,
        users: users);
  }
}
