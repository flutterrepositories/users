import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/src/bloc/users_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui/ui.dart';

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (c, state) {
      return view(c, state);
    });
  }

  void onPressOfButton() {
    FirebaseAuth.instance.signOut();
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

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CardStack(
                      color: Colors.white,
                      content: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FittedBox(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  firebaseUser.displayName != null
                                      ? Text(firebaseUser.displayName!,
                                          style: TextStyle(fontSize: 40.0))
                                      : Text('-'),
                                  firebaseUser.photoURL != null
                                      ? Image.network(
                                          firebaseUser.photoURL!,
                                          height: 100.0,
                                          width: 100.0,
                                        )
                                      : Text(""),
                                ]),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Text(user.username, style: TextStyle(fontSize: 20.0)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Expanded(
              child: ListView(
                children: user.awards.reversed.map((item) {
                  return ListTile(
                    title: CardStack(
                      color: Colors.white,
                      content: Text(item, style: TextStyle(fontSize: 16.0)),
                    ),
                    onTap: () {},
                  );
                }).toList(),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                child: DeleteUserButton()),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                child: LogOutButton()),
            Padding(padding: EdgeInsets.all(10.0)),
          ],
        ),
      ),
    );
  }
}
