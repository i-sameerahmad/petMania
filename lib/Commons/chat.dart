import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final List<dynamic> participantIds;

  const ChatPage({Key? key, required this.participantIds}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String chatRoomId;
  final TextEditingController _messageController = TextEditingController();
  late int userID;

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('userID'));
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    createChatRoom();
  }

  Future<void> createChatRoom() async {
    final participantIds = widget.participantIds;
    final sortedParticipantIds = participantIds..sort(); // Sort participant IDs to ensure consistency
    chatRoomId = sortedParticipantIds.join('_');

    // Create the chat room if it doesn't exist
    final chatRoomRef = FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId);
    final chatRoomSnapshot = await chatRoomRef.get();

    if (!chatRoomSnapshot.exists) {
      await chatRoomRef.set({
        'participantIds': sortedParticipantIds.map((id) => id.toString()).toList(),
      });
    }
  }

  void sendMessage(String message) {
    final chatRoomRef = FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId);
    chatRoomRef.collection('messages').add({
      'message': message,
      'timestamp': DateTime.now(),
      'senderId': userID,
    });

    _messageController.clear(); // Clear the text field after sending the message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).collection('messages').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final messages = snapshot.data?.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages?.length ?? 0,
                  itemBuilder: (context, index) {
                    final message = messages?[index].data() as Map<String, dynamic>?; // Cast to the expected type

                    final bool isSent = message?['senderId'] == userID;

                    // Extract the time part from the timestamp
                    final timestamp = (message?['timestamp'] as Timestamp?)?.toDate().toLocal();
                    final time = timestamp != null ? '${timestamp.hour}:${timestamp.minute}' : '';

                    // Bubble color based on sender
                    final bubbleColor = isSent ? Colors.blue : Colors.grey.shade300;

                    // Text color based on sender
                    final textColor = isSent ? Colors.white : Colors.black;

                    // Align the messages based on sender
                    final alignment = isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start;

                    // Message container decoration
                    final decoration = BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.circular(16.0),
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Column(
                        crossAxisAlignment: alignment,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                            decoration: decoration,
                            child: Text(
                              message?['message'] ?? '',
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            time,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a message...',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      sendMessage(message);
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
