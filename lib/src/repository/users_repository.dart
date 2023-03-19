import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:users/src/model/user.dart' as model;

import 'package:rxdart/rxdart.dart';

class UsersRepository {
  late final _items;
  final controller = BehaviorSubject<List<model.User>>();
  var _subscription;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  late String docId;

  UsersRepository() {
    _items = FirebaseFirestore.instance.collection("users2");

    cards.listen((event) {
      print(event);
    });
  }

  var collection = List<model.User>.empty();

  Stream<List<model.User>> get cards async* {
    _subscription = _items.snapshots().listen((event) async {
      var element = event.docs.first;
      docId = event.docs.first.id;

      var users = element.data()['users'] as List<dynamic>;
      var list = <model.User>[];
      users.forEach((value) {
        Map<String, dynamic> map = value as Map<String, dynamic>;
        var entity = model.UserEntityParser.fromMap(map);
        list.add(entity);
      });

      collection = list;
      controller.add(list);
    });
  }

  void addUsername(String name) {
    if (firebaseUser == null) return;
    var email = "";
    if (firebaseUser?.email != null) {
      email = firebaseUser!.email!;
    }

    model.User u = model.User(
        id: "1",
        email: email,
        userid: firebaseUser!.uid,
        username: name,
        points: {'start': 0},
        awards: []);

    FirebaseFirestore.instance.collection("users2").get().then((event) async {
      var element = event.docs.first;
      var docId = event.docs.first.id;

      var users = element.data()['users'] as List<dynamic>;
      List<Map<String, dynamic>> lu = List.empty(growable: true);

      users.forEach((value) {
        var user =
            model.UserEntityParser.fromMap(value as Map<String, dynamic>);
        lu.add(user.toData());
      });
      lu.add(u.toData());

      FirebaseFirestore.instance
          .collection("users2")
          .doc(docId)
          .update({'users': lu});
    });
  }

  void dispose() {
    _subscription.cancel();
    controller.close();
  }
}
