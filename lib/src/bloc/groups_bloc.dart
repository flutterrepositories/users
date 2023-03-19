import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:users/src/repository/groups_repository.dart';
import 'package:users/src/model/group.dart' as model;
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc() : super(GroupsState([], '', '')) {
    on<GroupsChanged>(_onGroupsChanged);
    on<CreateGroup>(_onCreateGroup);
    on<JoingGroup>(_onJoinGroup);

    userIdController.stream.listen((userId) {
      _repository.userIdController.add(userId);
    });

    Stream<GroupsEvent> events = CombineLatestStream.list([
      _repository.controller.stream,
      deckIdController.stream,
    ]).map((event) {
      List<model.Group> groups = event[0] as List<model.Group>;
      String deckId = event[1] as String;

      return GroupsChanged(groups, deckId, _repository.userId);
    });

    _subscription = events.listen((e) {
      add(e);
    });
  }

  final userIdController = StreamController<String>();
  final deckIdController = StreamController<String>();

  late final GroupsRepository _repository = GroupsRepository();
  late StreamSubscription<GroupsEvent> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    _repository.dispose();
    return super.close();
  }

  FutureOr<void> _onGroupsChanged(
      GroupsChanged event, Emitter<GroupsState> emit) {
    emit(GroupsState(event.groups, event.deckid, event.userid));
  }

  FutureOr<void> _onCreateGroup(CreateGroup event, Emitter<GroupsState> emit) {
    _repository.createGroup(event.name);
  }

  FutureOr<void> _onJoinGroup(JoingGroup event, Emitter<GroupsState> emit) {
    _repository.joinGroup(event.id);
  }
}
