import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pet_paradise/Backend/Auth/auth.dart';
import 'package:pet_paradise/Commons/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool open = false;
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatRoomsStream;
  final AuthNotifier _auth = AuthNotifier();
  late int userId;
  List<String> chatRooms = [];
  late String opname = "";

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userID') ?? 0;
    });

    final chatRooms = await fetchChatRooms();
    setState(() {
      this.chatRooms = chatRooms;
      chatRoomsStream = FirebaseFirestore.instance.collection('chatRooms').where('participantIds', arrayContains: userId.toString()).snapshots();
    });
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
  }

  Future<List<String>> fetchChatRooms() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('chatRooms').get();
    final chatRooms = querySnapshot.docs.map((doc) => doc.id).toList();
    print(chatRooms);
    return chatRooms;
  }

  Future<String> fetchnames(String id) async {
    opname = await _auth.fetchNames(id);
    print(opname);
    return opname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: const Text('Flash Chat'),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  open = !open;
                });
              },
              icon: Icon(
                open ? Icons.close_rounded : Icons.search_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   margin: const EdgeInsets.all(0),
                //   child: Container(
                //     color: Colors.indigo.shade400,
                //     padding: const EdgeInsets.all(8),
                //     height: 160,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Spacer(),
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                //           child: Text(
                //             'Recent Users',
                //             style: Styles.h1(),
                //           ),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.symmetric(vertical: 10),
                //           height: 80,
                //           child: ListView.builder(
                //             scrollDirection: Axis.horizontal,
                //             itemBuilder: (context, i) {
                //               return ChatWidgets.circleProfile();
                //             },
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Text(
                            'Contacts',
                            style: Styles.h1(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: chatRoomsStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final chatRoomDocs = snapshot.data!.docs;
                                  return ListView.builder(
                                    itemCount: chatRoomDocs.length,
                                    itemBuilder: (context, index) {
                                      final chatRoom = chatRoomDocs[index].data();
                                      final chatRoomId = chatRoomDocs[index].id;
                                      final participantIds = chatRoom['participantIds'] as List;
                                      final otherParticipantId = participantIds.firstWhere((id) => id != userId.toString(), orElse: () => '') as String;
                                      final name = fetchnames(otherParticipantId);
                                      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                        stream: FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).collection('messages').orderBy('timestamp', descending: true).limit(1).snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final messageDocs = snapshot.data!.docs;
                                            if (messageDocs.isNotEmpty) {
                                              final lastMessage = messageDocs[0].data();
                                              final timestamp = lastMessage['timestamp'] as Timestamp;
                                              final messageTime = timestamp.toDate();
                                              return ChatWidgets.card(
                                                title: opname,
                                                subtitle: lastMessage['message'] ?? 'No messages',
                                                time: messageTime,
                                                onTap: () {
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => ChatPage(
                                                            participantIds: participantIds,
                                                          )));
                                                },
                                              );
                                            }
                                          }
                                          return const SizedBox();
                                        },
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Styles {
  static BoxDecoration friendsBox() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }

  static TextStyle h1() {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }
}

class ChatWidgets {
  static Widget card({required String title, required String subtitle, required DateTime time, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(DateFormat('kk:mm').format(time)),
      onTap: onTap,
    );
  }
}
