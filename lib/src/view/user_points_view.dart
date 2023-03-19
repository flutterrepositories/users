import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/src/bloc/users_bloc.dart';

class UserPointsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (c, state) {
      return view(c, state);
    });
  }

  Widget view(BuildContext c, UsersState state) {
    int? points = state.users.length > 0
        ? state.users
            .firstWhere((element) => state.userid == element.userid)
            .points[state.deckid]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            Text(
              "Punti",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
            Text(
              points != null ? points.toString() : "-",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 36.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
