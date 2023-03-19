part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

class GroupsChanged extends GroupsEvent {
  const GroupsChanged(this.groups, this.deckid, this.userid) : super();

  final List<model.Group> groups;
  final String userid;
  final String deckid;

  @override
  List<Object> get props => [groups, deckid, userid];
}

class CreateGroup extends GroupsEvent {
  const CreateGroup(this.name) : super();

  final String name;

  @override
  List<Object> get props => [DateTime.now().microsecondsSinceEpoch];
}


class JoingGroup extends GroupsEvent {
  const JoingGroup(this.id) : super();

  final String id;

  @override
  List<Object> get props => [DateTime.now().microsecondsSinceEpoch];
}
