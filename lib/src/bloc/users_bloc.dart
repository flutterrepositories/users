import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:users/src/repository/users_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:users/src/model/user.dart' as model;

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this.deckid, this.userid) : super(UsersState([], deckid, userid)) {
    on<UsersChanged>(_onUsersChanged);
    on<UsernameEmpty>(_onUsernameEmpty);
    on<AddUsername>(_onAddUsername);

    Stream<UsersEvent> events = _usersRepository.controller.stream.map((users) {
      return UsersChanged(users, deckid, userid);
    });

    _subscription = events.listen((e) {
      add(e);
    });
  }
  String userid;
  String deckid;
  late final UsersRepository _usersRepository = UsersRepository();
  late StreamSubscription<UsersEvent> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    _usersRepository.dispose();
    return super.close();
  }

  FutureOr<void> _onUsersChanged(UsersChanged event, Emitter<UsersState> emit) {
    model.User? user = null;
    event.users.forEach((element) {
      if (element.userid == event.userid) user = element;
    });
    if (user == null) {
      add(UsernameEmpty(event.users, event.deckid, event.userid));
    }

    emit(UsersState(event.users, event.deckid, event.userid));
  }

  FutureOr<void> _onUsernameEmpty(
      UsernameEmpty event, Emitter<UsersState> emit) async {
    emit(RequestUsername(event.users, event.deckid, event.userid));
  }

  FutureOr<void> _onAddUsername(AddUsername event, Emitter<UsersState> emit) {
    _usersRepository.addUsername(event.idInput);
  }
}
