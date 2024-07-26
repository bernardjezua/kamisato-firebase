import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kamisato/screens/slambook_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation/drawer.dart';
import '../models/friend_model.dart';
import '../providers/friends_provider.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> friendsStream = context.watch<FriendListProvider>().friend;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text("Friends List"),
      ),
      body: StreamBuilder(
        stream: friendsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
            return Center(
              child: Column( // Shows if friendsList is empty
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.group, size: 40, color: Colors.amber[700]),
                  const Text("No friends added yet."),
                  const SizedBox(height: 10),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    child: FloatingActionButton.extended(
                      heroTag: 'addFriend',
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SlamBookForm()),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add Friend"),
                    ),
                  ),
                ],
              ),
            );
          } else { return Center(
            child: Column( // Shows if friendsList is not empty
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Icon(Icons.people, size: 40, color: Colors.amber[700]),
                      Text(
                        "Total Friends: ${snapshot.data?.docs.length}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SlamBookForm()),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Add Friend"),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: ((context, index) {
                      Friend friend = Friend.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>);
                      friend.id = snapshot.data?.docs[index].id;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(friend.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // Pass the friend object to the details page
                                Navigator.pushNamed(context, "/details", arguments: friend);
                              },
                              icon: const Icon(Icons.notes),
                              label: const Text("View"),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
        }
        }
      ),
    );
  }
}
