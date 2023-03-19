import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:users/src/model/group.dart' as model;

class GroupsRepository {
  final controller = StreamController<List<model.Group>>();
  final userIdController = StreamController<String>();

  var userId = '';

  GroupsRepository() {
    userIdController.stream.listen((uid) {
      userId = uid;
      FirebaseFirestore.instance
          .collection("groups")
          .where("users", arrayContains: userId)
          .snapshots()
          .listen((event) async {
        var list = <model.Group>[];
        event.docs.forEach((element) {
          var entity = model.GroupEntityParser.fromSnapshot(element);
          list.add(entity);
        });

        collection = list;
        controller.add(list);
      });
    });
  }

  var collection = List<model.Group>.empty();

  void createGroup(String name) {
    FirebaseFirestore.instance.collection("groups").doc().set({
      "name": name,
      "users": [userId],
      "admins": [userId],
    });
  }

  void joinGroup(String id) {
    FirebaseFirestore.instance.collection("groups").doc(id).update({
      'users': FieldValue.arrayUnion([userId]),
    });
  }

  void dispose() {}
}
