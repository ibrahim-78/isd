import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  final String university;
  final String channel;

  ChatScreen({required this.university, required this.channel});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  TextEditingController _controller = TextEditingController();
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    final url =
        'http://192.168.1.117:4000/messages'; // Adjust the URL to your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> messageJson = json.decode(response.body);
        setState(() {
          _messages =
              messageJson.map((json) => Message.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load messages';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load messages: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _sendMessage(String message) async {
    final url =
        'http://192.168.1.117:4000/messages'; // Adjust the URL to your API endpoint

    final newMessage = Message(
      user: 'username', // Replace with actual user name
      message: message,
      channel: widget.channel,
      timestamp: DateTime.now(),
    );

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newMessage.toJson()),
      );

      if (response.statusCode == 201) {
        _controller.clear();
        _fetchMessages(); // Refresh the message list after sending a new message
      } else {
        setState(() {
          _error = 'Failed to send message';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to send message: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channel),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text('Error: $_error'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return ListTile(
                            title: Text(message.message),
                            subtitle:
                                Text('${message.user} - ${message.timestamp}'),
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
