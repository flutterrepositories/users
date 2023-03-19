import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui/ui.dart';
import 'package:users/src/view/group_ranking_view.dart';
import 'package:users/users.dart';

class GroupsListView extends StatelessWidget {
  String appName;
  String shortLink;
  GroupsListView({required this.appName, required this.shortLink});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, GroupsState>(builder: (c, state) {
      return view(c, state);
    });
  }

  Widget view(BuildContext c, GroupsState state) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      return Container(
        child: Center(
          child: Text('Please login'),
        ),
      );
    }

    return ListView.builder(
        itemBuilder: (c, i) {
          var u = state.groups[i];
          return CardStack(
            color: Colors.white,
            content: Column(
              children: [
                ListTile(
                  title: Text('${u.name}'),
                  subtitle: Text('${u.users.length} Giocatori'),
                  trailing: PopupMenuButton<String>(
                    key: Key("${u.id}"),
                    onSelected: (String result) async {
                      Uri deeplink = await _createDynamicLink(true, u.id);

                      Share.share(deeplink.toString());
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: "share",
                        child: const Text('Condividi Gruppo'),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(c, MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider<UsersBloc>(
                              create: (context) =>
                                  BlocProvider.of<UsersBloc>(c)),
                        ],
                        child: GenericPage(
                            appName: appName, body: GroupRankingView(u)),
                      );
                    }));
                  },
                ),
              ],
            ),
          );
        },
        itemCount: state.groups.length);
  }

  Future<Uri> _createDynamicLink(bool short, String groupID) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: shortLink,
      link: Uri.parse('http://www.unoxdue.it/group/' + groupID),
      androidParameters: new AndroidParameters(
        packageName: 'com.unoxdue.fsapp',
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.unoxdue.app',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    return url;
  }
}
