import 'package:flutter/material.dart';
import 'package:users/src/bloc/groups_bloc.dart';

// ignore: must_be_immutable
class CreateGroupView extends StatelessWidget {
  GroupsBloc bloc;
  String appName;
  CreateGroupView({required this.appName, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return view(context);
  }

  Widget view(BuildContext c) {
    String idInput = '';

    return AlertDialog(
      title: Text(appName),
      content: TextField(
        decoration: InputDecoration(labelText: "Nome Gruppo"),
        onChanged: (String text) {
          idInput = text;
        },
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Ok"),
          onPressed: () {
            bloc.add(CreateGroup(idInput));
            Navigator.pop(c);
          },
        ),
      ],
    );
  }
}
