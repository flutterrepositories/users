import 'package:flutter/material.dart';
import 'package:users/users.dart';

// ignore: must_be_immutable
class AddUsernameView extends StatelessWidget {
  UsersBloc bloc;
  String appName;
  AddUsernameView({required this.appName, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return view(context);
  }

  Widget view(BuildContext c) {
    String idInput = '';

    return AlertDialog(
      title: Text(appName),
      content: TextField(
        decoration: InputDecoration(labelText: "Username"),
        onChanged: (String text) {
          idInput = text;
        },
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Ok"),
          onPressed: () {
            bloc.add(AddUsername(idInput));
          },
        ),
      ],
    );
  }
}
