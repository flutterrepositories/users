part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class AddUsername extends UsersEvent {
  final String idInput;

  const AddUsername(this.idInput);

  @override
  List<Object> get props => [idInput];
}

class UsersChanged extends UsersEvent {
  const UsersChanged(this.users, this.deckid, this.userid) : super();

  final List<model.User> users;
  final String userid;
  final String deckid;

  @override
  List<Object> get props => [users, deckid, userid];
}

class UsernameEmpty extends UsersEvent {
  const UsernameEmpty(this.users, this.deckid, this.userid) : super();

  final List<model.User> users;
  final String userid;
  final String deckid;

  @override
  List<Object> get props => [users, deckid, userid];
}
