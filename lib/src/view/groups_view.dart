import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/src/bloc/groups_bloc.dart';

class GroupsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, GroupsState>(builder: (c, state) {
      return view(c, state);
    });
  }

  Widget view(BuildContext c, GroupsState state) {
    int length = state.groups.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Sei iscritto a ${length} gruppi",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14.0,
              )),
        ),
      ],
    );
  }
}
