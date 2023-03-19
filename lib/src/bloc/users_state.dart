part of 'users_bloc.dart';

class UsersState extends Equatable {
  const UsersState(this.users, this.deckid, this.userid);

  final List<model.User> users;
  final String userid;
  final String deckid;

  @override
  List<Object> get props => [users, deckid, userid];
}

class RequestUsername extends UsersState {
  const RequestUsername(this.users, this.deckid, this.userid)
      : super(users, deckid, userid);

  final List<model.User> users;
  final String userid;
  final String deckid;

  @override
  List<Object> get props => [users, deckid, userid];
}
