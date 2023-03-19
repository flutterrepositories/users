import 'package:users/src/model/user.dart' as model;
import 'package:users/src/model/group.dart';

import 'package:users/src/bloc/users_bloc.dart';
import 'package:users/src/view/ranking_view.dart';

// ignore: must_be_immutable
class GroupRankingView extends RankingView {
  Group group;
  GroupRankingView(this.group);

  @override
  List<model.User> getUsers(UsersState state) {
    var usersWithPoints =
        state.users.where((u) => u.points[state.deckid] != null);
    var groupList = usersWithPoints
        .where((element) => group.users.contains(element.userid))
        .toList();
    groupList.sort((a, b) =>
        a.points[state.deckid]?.compareTo(b.points[state.deckid] ?? 0) ?? 0);
    groupList = groupList.reversed.toList();
    return groupList;
  }
}
