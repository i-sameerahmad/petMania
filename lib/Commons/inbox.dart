import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:pet_paradise/Commons/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool open = false;
  late Stream<QuerySnapshot<Map<String, dynamic>>> chatRoomsStream;
  late int userId;

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userID') ?? 0;
      print(userId);
    });
    initializeChatRoomsStream();
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
  }

  Stream<List<DocumentSnapshot>> initializeChatRoomsStream() {
    final chatRoomsRef = FirebaseFirestore.instance.collection('chatRooms');

    return chatRoomsRef
        .where('participantIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs);
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
                Container(
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    color: Colors.indigo.shade400,
                    padding: const EdgeInsets.all(8),
                    height: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Text(
                            'Recent Users',
                            style: Styles.h1(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return ChatWidgets.circleProfile();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Contacts',
                            style: Styles.h1().copyWith(color: Colors.indigo),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                              stream: chatRoomsStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final chatRoomDocs = snapshot.data!.docs;
                                  return ListView.builder(
                                    itemCount: chatRoomDocs.length,
                                    itemBuilder: (context, index) {
                                      final chatRoom =
                                          chatRoomDocs[index].data();
                                      final chatRoomId = chatRoomDocs[index].id;
                                      final participantIds =
                                          chatRoom['participantIds'] as List?;
                                      final otherParticipantId =
                                          participantIds?.firstWhere(
                                              (id) => id != userId.toString(),
                                              orElse: () => '');

                                      return StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                        stream: FirebaseFirestore.instance
                                            .collection('chatRooms')
                                            .doc(chatRoomId)
                                            .collection(chatRoomId)
                                            .orderBy('timestamp',
                                                descending: true)
                                            .limit(1)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final messageDocs =
                                                snapshot.data!.docs;
                                            if (messageDocs.isNotEmpty) {
                                              final lastMessage =
                                                  messageDocs[0].data();
                                              return ChatWidgets.card(
                                                title: otherParticipantId,
                                                subtitle:
                                                    lastMessage['message'] ??
                                                        'No messages',
                                                time: lastMessage['timestamp'],
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ChatPage(
                                                          participantIds:
                                                              participantIds
                                                                  as List<
                                                                      String>,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          }
                                          return const SizedBox();
                                        },
                                      );
                                    },
                                  );
                                }
                                return const CircularProgressIndicator();
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
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: open ? 110 : 10,
              right: open ? 10 : MediaQuery.of(context).size.width / 2 - 25,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: open ? MediaQuery.of(context).size.width - 20 : 50,
                height: open ? MediaQuery.of(context).size.height - 120 : 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(open ? 12 : 25),
                  color: open ? Colors.white : Colors.indigo.shade400,
                ),
                child: open
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 20, right: 10, left: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      open = !open;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.indigo.shade400,
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text('User $i'),
                                    onTap: () {},
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatWidgets {
  static Widget circleProfile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.indigo.shade400,
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'User',
            style: Styles.subtitle(),
          ),
        ],
      ),
    );
  }

  static Widget card({
    required String title,
    required String subtitle,
    required Timestamp time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.indigo.shade400,
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: Text(
            title,
            style: Styles.h1(),
          ),
          subtitle: Text(
            subtitle,
            style: Styles.subtitle(),
          ),
          trailing: Text(
            DateFormat('HH:mm').format(time.toDate()),
            style: Styles.subtitle(),
          ),
        ),
      ),
    );
  }
}

class Styles {
  static TextStyle h1() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle subtitle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
  }

  static BoxDecoration friendsBox() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }
}
