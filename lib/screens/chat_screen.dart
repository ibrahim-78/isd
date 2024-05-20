import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  final String university;
  final String channel;

  ChatScreen({required this.university, required this.channel});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel _channel;
  List<Message> _messages = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _channel = IOWebSocketChannel.connect('ws://localhost:4000');
    _fetchMessages();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void _fetchMessages() {
    _channel.stream.listen((message) {
      final List<dynamic> messageJson = json.decode(message);
      setState(() {
        _messages = messageJson.map((json) => Message.fromJson(json)).toList();
      });
    });
  }

  void _sendMessage(String message) {
    final newMessage = Message(
      user: 'username', // Replace with actual user name
      message: message,
      channel: widget.channel,
      timestamp: DateTime.now(),
    );

    _channel.sink.add(json.encode(newMessage.toJson()));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channel),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.message),
                  subtitle: Text('${message.user} - ${message.timestamp}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
