class Message {
  final int messageId;
  final int senderId;
  final int recipientId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.messageId,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.timestamp,
  });
}
