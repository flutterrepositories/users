import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/src/bloc/users_bloc.dart';
import 'package:users/src/model/user.dart' as model;

// ignore: must_be_immutable
class RankingView extends StatelessWidget {
  RankingView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (c, state) {
      return view(c, state);
    });
  }

  Widget view(BuildContext c, UsersState state) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      return Container(
        child: Center(
          child: Text('Please login'),
        ),
      );
    }

    var user = state.users.firstWhere((u) => u.userid == firebaseUser.uid);
    // all the users that has value for this deck
    var users = getUsers(state);
    var points = users.map((u) => u.points[state.deckid]).toSet().toList();
    points.sort();
    points = points.reversed.toList();

    var positions = points.asMap();

    return ListView.separated(
        itemBuilder: (c, i) {
          var u = users[i];
          var points = u.points[state.deckid] ?? 0;
          var position = 0;
          positions.forEach((key, value) {
            if (value == points) {
              position = key;
            }
          });
          var style = TextStyle(
            color: (u.userid == user.userid) ? Colors.green : Colors.black,
          );
          return ListTile(
            title: Text('${position + 1} - ${u.username}', style: style),
            trailing: Text(
              points.toString(),
              style: style,
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(color: Colors.black),
        itemCount: users.length);
  }

  List<model.User> getUsers(UsersState state) {
    var usersWithPoints =
        state.users.where((u) => u.points[state.deckid] != null);
    var v = usersWithPoints.toList();
    v.sort((a, b) =>
        a.points[state.deckid]?.compareTo(b.points[state.deckid] ?? 0) ?? 0);
    v = v.reversed.toList();
    return v;
  }
}
