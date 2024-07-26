import 'package:kamisato/navigation/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/friends_provider.dart';
import '../models/friend_model.dart';

class FriendSummary extends StatefulWidget {
  const FriendSummary({super.key});

  @override
  _FriendSummaryState createState() => _FriendSummaryState();
}

class _FriendSummaryState extends State<FriendSummary> {
  Friend? friend;

  // Called when a dependency of this state object changes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    friend = ModalRoute.of(context)?.settings.arguments as Friend?; // Retrieves the friend instance from the arguments
  }

  @override
  Widget build(BuildContext context) {
    final title = friend?.name ?? "N/A";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 350,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Icon(Icons.book_rounded, size: 40, color: Colors.amber[700]),
                    ),
                    const Center(
                      child: Text(
                        "Summary",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(color: Colors.blue),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          children: [
                            const Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(friend?.name ?? "N/A"),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("Nickname", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(friend?.nickname ?? "N/A"),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("Age", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(friend?.age.toString() ?? "N/A"),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("Relationship", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(friend?.isSingle == true ? "Single" : "Taken"),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("Happiness", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(friend?.happinessLevel.toString() ?? "N/A"),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("Vision", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(friend?.vision ?? "N/A"),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("Motto", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(friend?.motto ?? "N/A", textAlign: TextAlign.justify),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);

                            },
                            icon: const Icon(Icons.arrow_back),
                            label: const Text("Back"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Center(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "/edit", arguments: friend);
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text("Edit"),
                          ),
                        ),
                        const SizedBox(width: 10), 
                        Center(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (friend != null) {
                                context.read<FriendListProvider>().deleteFriend(friend!);
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                  const SnackBar(content: Text("Deleted friend")),
                                );
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text("Delete"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}