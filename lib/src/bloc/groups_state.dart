part of 'groups_bloc.dart';

class GroupsState extends Equatable {
  const GroupsState(this.groups, this.deckid, this.userid);

  final List<model.Group> groups;
  final String userid;
  final String deckid;

  @override
  List<Object> get props => [groups, deckid, userid];
}