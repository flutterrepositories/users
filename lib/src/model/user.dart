import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String email;
  String userid;
  String username;
  Map<String, int> points;
  List<String> awards;

  User(
      {required this.id,
      required this.email,
      required this.userid,
      required this.username,
      required this.points,
      required this.awards});

  Map<String, dynamic> toData() {
    return {
      "userid": userid,
      "email": email,
      "username": username,
      "awards": awards,
      "points": points
    };
  }
}

extension UserEntityParser on User {
  static User fromMap(Map<String, dynamic> map) {
    Map<String, int> points = Map<String, int>();
    List<String> awards = List<String>.empty(growable: true);

    Map<String, dynamic> pval = map['points'] as Map<String, dynamic>;
    pval.forEach((key, value) {
      points[key] = int.parse(value.toString());
    });

    List<dynamic> aval = map['awards'] as List<dynamic>;
    aval.forEach((value) {
      awards.add(value as String);
    });

    var email = "";
    if (map['email'] != null) {
      email = map['email'];
    }

    return User(
        id: map['userid'],
        email: email,
        userid: map['userid'],
        username: map['username'],
        points: points,
        awards: awards);
  }
}
