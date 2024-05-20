class Message {
  final String user;
  final String message;
  final String channel;
  final DateTime timestamp;

  Message({
    required this.user,
    required this.message,
    required this.channel,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      user: json['user'],
      message: json['message'],
      channel: json['channel'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'message': message,
      'channel': channel,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
