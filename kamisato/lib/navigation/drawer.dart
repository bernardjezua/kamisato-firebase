import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/friends_provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    final friendsProvider = context.read<FriendListProvider>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Center(
                child: Text(
                  "Kamisato Records",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Friends"),
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != '/') {
                Navigator.pushReplacementNamed(context, '/');
              }
              friendsProvider.fetchFriends();
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text("Slambook"),
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != '/slambook') {
                Navigator.pushReplacementNamed(context, '/slambook');
              }
              friendsProvider.fetchFriends();
            },
          ),
        ],
      ),
    );
  }
}