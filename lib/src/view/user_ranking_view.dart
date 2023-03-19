import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/src/bloc/users_bloc.dart';
import 'package:users/src/model/user.dart';

class UserRankingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (c, state) {
      return view(c, state);
    });
  }

  Widget view(BuildContext c, UsersState state) {
    // get list of users that have a value in the points field
    var users = getUsers(state);

    var userpoints = users.map((u) => u.points[state.deckid]).toSet().toList();
    userpoints.sort();
    userpoints = userpoints.reversed.toList();

    var positions = userpoints.asMap();

    var position = 0;

    if (users.length > 0) {
      var p = 0;
      users.forEach((element) {
        if (element.userid == state.userid) {
          p = element.points[state.deckid] ?? 0;
        }
      });
      // var p = users
      //         .firstWhere((element) => element.userid == state.userid)
      //         .points[state.deckid] ??
      //     0;
      positions.forEach((key, value) {
        if (value == p) {
          position = key;
        }
      });
    }

    return Column(children: [
      Text(
        "Posizione",
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10.0,
        ),
      ),
      Text(
        users.length > 0 ? (position + 1).toString() : "-",
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 36.0,
        ),
      )
    ]);
  }

  List<User> getUsers(UsersState state) {
    var usersWithPoints =
        state.users.where((u) => u.points[state.deckid] != null);
    var v = usersWithPoints.toList();
    v.sort((a, b) =>
        a.points[state.deckid]?.compareTo(b.points[state.deckid] ?? 0) ?? 0);
    v = v.reversed.toList();
    return v;
  }
}
